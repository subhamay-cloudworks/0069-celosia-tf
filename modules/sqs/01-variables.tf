## ---------------------------------------------------------------------------------------------------------------------
## Variable Definition - SQS Module
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
######################################## SQS Queue #################################################
variable "sqs_queue_base_name" {
  description = "The base name of the SQS Queue"
  type        = string
  default     = "sqs-queue"
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
######################################## Local Variables ###########################################
locals {
  tags = tomap({
    Environment = var.environment_name
    ProjectName = var.project_name
  })
}

locals {
  queue_name = "${var.sqs_queue_base_name}-${var.environment_name}-${data.aws_region.current.name}"
}