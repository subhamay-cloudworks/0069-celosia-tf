## ---------------------------------------------------------------------------------------------------------------------
## Lambda - Main 
## Modification History:
##   - 1.0.0    Jun 3,2023   -- Initial Version
## ---------------------------------------------------------------------------------------------------------------------

## Lambda Function
resource "aws_lambda_function" "lambda-function" {
  # If the file is not in the current working directory you will need to include a
  # path.module in the filename.
  filename                       = "../modules/lambda/code/celosia_code.zip"
  function_name                  = local.lambda_function_name
  description                    = var.lambda_function_description
  role                           = var.iam_role_name
  handler                        = "celosia_code.lambda_handler"
  memory_size                    = var.memory_size
  timeout                        = var.timeout
  runtime                        = var.runtime
  source_code_hash               = data.archive_file.package_zip.output_base64sha256
  reserved_concurrent_executions = var.reserved_concurrent_executions
  environment {
    variables = {
      DYNAMODB_TABLE_NAME = "${local.dynamodb_table_name}"
    }
  }
  tags = local.tags
}
