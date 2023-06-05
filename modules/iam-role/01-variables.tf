## ---------------------------------------------------------------------------------------------------------------------
## Variable Definition - IAM Execution Role Module
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
  description = "KMS Key Alias"
  type        = string
  default     = ""
}

variable "kms_key_arn" {
  description = "KMS Key Arn"
  type        = map(string)
  default = {
    "us-east-1" = "arn:aws:kms:us-east-1:807724355529:key/e4c733c5-9fbe-4a90-bda1-6f0362bc9b89"
  }
}
######################################## IAM Role / Policy #########################################
variable "lambda_iam_role_name" {
  description = "The name of the Lambda IAM Role"
  type        = string
  default     = "lambda-iam-role"
}

variable "lambda_iam_policy_name" {
  description = "The name of the Lambda IAM Policy"
  type        = string
  default     = "lambda-iam-policy"
}

variable "sf_iam_role_name" {
  description = "The name of the Step Function IAM Role"
  type        = string
  default     = "step-function-iam-role"
}

variable "sf_iam_policy_name" {
  description = "The name of the Step Function IAM Policy"
  type        = string
  default     = "step-function-iam-policy"
}
######################################## Lambda Function  ##########################################
variable "lambda_function_base_name" {
  description = "The base name of the lambda function"
  type        = string
  default     = "lambda-function-name"
}
######################################## DynamoDB Table ############################################
variable "dynamodb_table_base_name" {
  description = "The base name of the DynamoDB table"
  type        = string
  default     = "tarius-product-table"
}
######################################## SQS Queue #################################################
variable "sqs_queue_base_name" {
  description = "The base name of the SQS Queue"
  type        = string
  default     = "sqs-queue"
}
######################################## Local Variables ###########################################
locals {
  tags = tomap({
    Environment = var.environment_name
    ProjectName = var.project_name
  })
}

locals {
  lambda_function_name = "${var.lambda_function_base_name}-${var.environment_name}-${data.aws_region.current.name}"
}

locals {
  dynamodb_table_name = "${var.dynamodb_table_base_name}-${var.environment_name}-${data.aws_region.current.name}"
}

locals {
  sqs_queue_name = "${var.sqs_queue_base_name}-${var.environment_name}-${data.aws_region.current.name}"
}
