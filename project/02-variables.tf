## ---------------------------------------------------------------------------------------------------------------------
## Variable Definition - Project Celosia
## Modification History:
##   - 1.0.0    Jun 3,2023   -- Initial Version
## ---------------------------------------------------------------------------------------------------------------------

data "aws_region" "current" {}
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
  default     = "SB-KMS"
}
variable "kms_key_arn" {
  description = "KMS Key Arn"
  type        = map(string)
  default = {
    "region-name" = "kms-key-arn"
  }
}
######################################## DynamoDB Table ############################################
variable "dynamodb_table_base_name" {
  description = "The base name of the DynamoDB Table"
  type        = string
  default     = "celosia-table"
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
######################################## SQS Queue #################################################
variable "sqs_queue_base_name" {
  description = "The base name of the SQS Queue"
  type        = string
  default     = "celosia-sqs-queue"
}

variable "delay_seconds" {
  description = "SQS queue delay seconds"
  type        = number
  default     = 0
}

variable "max_message_size" {
  description = "SQS queue maximum message size"
  type        = number
  default     = 0
}

variable "message_retention_seconds" {
  description = "SQS queue message retention period in seconds"
  type        = number
  default     = 0
}
variable "receive_wait_time_seconds" {
  description = "SQS queue receive wait time in seconds"
  type        = number
  default     = 0
}
######################################## SNS Topic #################################################
variable "sns_topic_base_name" {
  description = "The base name of the SNS Topic"
  type        = string
  default     = "tarius-sns-topic"
}

variable "sns_topic_display_name" {
  description = "The display name of the SNS Topic"
  type        = string
  default     = "SNS Topic to send a notification once the data load is complete."
}
######################################## SNS Topic Subscription ####################################
variable "sns_subscription_email" {
  description = "The SNS subscription email"
  type        = list(string)
  default     = ["someone@email.com"]
}
######################################## Lambda IAM Role / Policy ##################################
variable "lambda_iam_role_name" {
  description = "The name of the Lambda IAM Role"
  type        = string
  default     = "iam-role"
}

variable "lambda_iam_policy_name" {
  description = "The name of the IAM Policy"
  type        = string
  default     = "iam-policy"
}
######################################## Lambda IAM Role / Policy ##################################
variable "sf_iam_role_name" {
  description = "The name of the State Machine IAM Role"
  type        = string
  default     = "step-function-iam-role"
}

variable "sf_iam_policy_name" {
  description = "The name of the Step Function IAM Policy"
  type        = string
  default     = "step-function-policy"
}
######################################## Lambda Function  ##########################################
variable "lambda_function_base_name" {
  description = "The base name of the lambda function"
  type        = string
  default     = "lambda-function-name"
}

variable "lambda_function_description" {
  description = "The description of the lambda function"
  type        = string
  default     = "Lambda function description"
}

variable "memory_size" {
  description = "The allocated memory size of the lambda function in MB"
  type        = number
  default     = 128
}

variable "runtime" {
  description = "The runtime the lambda function"
  type        = string
  default     = "python3.9"
}

variable "timeout" {
  description = "The timeout period of the lambda function in seconds"
  type        = number
  default     = 3
}

variable "reserved_concurrent_executions" {
  description = "The reserved concurrency for the lambda function."
  type        = number
  default     = 1
}