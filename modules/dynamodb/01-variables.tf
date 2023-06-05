## ---------------------------------------------------------------------------------------------------------------------
## Variable Definition - DynamoDB Module
## Modification History:
##   - 1.0.0    Jun 3,2023   -- Initial Version
## ---------------------------------------------------------------------------------------------------------------------

######################################## Project Name ##############################################
variable "project_name" {
  description = "The name of the project"
  type        = string
  default     = "project"
}
######################################## Environment Name ##########################################
variable "environment_name" {
  type        = string
  description = <<EOT
  (Optional) The environment in which to deploy our resources to.

  Options:
  - devl : Development
  - test: Test
  - prod: Production

  Default: devl
  EOT
  default     = "devl"

  validation {
    condition     = can(regex("^devl$|^test$|^prod$", var.environment_name))
    error_message = "Err: environment is not valid."
  }
}
######################################## KMS Key ###################################################
variable "kms_key_alias" {
  description = "KMS Key Id"
  type        = string
  default     = "SB-KMS"
}

variable "kms_key_arn" {
  description = "KMS Key Arn"
  type        = map(string)
  default = {
    aws-region = "kms-key-arn"
  }
}
######################################## DynamoDB Table ############################################
variable "dynamodb_table_base_name" {
  description = "The name of the DynamoDB table"
  type        = string
  default     = "dynamodb-table-name"
}

variable "partition_key" {
  description = "The partition key or hash key of the dynamodb table."
  type        = string
  default     = "partition-key"
}

variable "partition_key_data_type" {
  description = "The partition key or hash key datat type of the dynamodb table."
  type        = string
  default     = "S"
}
######################################## Local Variables ###########################################
locals {
  tags = tomap({
    Environment = var.environment_name
    ProjectName = var.project_name
  })
}

locals {
  dynamodb_table_name = "${var.dynamodb_table_base_name}-${var.environment_name}-${data.aws_region.current.name}"
}