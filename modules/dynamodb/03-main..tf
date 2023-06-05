## ---------------------------------------------------------------------------------------------------------------------
## DynamoDB - Main 
## Modification History:
##   - 1.0.0    Jun 3,2023   -- Initial Version
## ---------------------------------------------------------------------------------------------------------------------

## DynamoDB Table
resource "aws_dynamodb_table" "dynamodb_table" {
  name         = local.dynamodb_table_name
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = var.partition_key
  attribute {
    name = var.partition_key
    type = var.partition_key_data_type
  }

  dynamic "server_side_encryption" {
    for_each = var.environment_name == "prod" || var.environment_name == "test" ? [true] : []
    content {
      enabled     = true
      kms_key_arn = lookup(var.kms_key_arn, data.aws_region.current.name, "us-east-1")
    }
  }
  tags = local.tags
}

