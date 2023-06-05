## ---------------------------------------------------------------------------------------------------------------------
## Variable Definition - CloudWatch Alarm Module
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
######################################## Lambda Function ###########################################
variable "lambda_function_base_name" {
  description = "The base name of the lambda function"
  type        = string
  default     = "lambda-function-name"
}
######################################## CloudWatch Alarm ##########################################
variable "cloudwatch_alarm_namespace" {
  description = "The CloudWatch Alarm namespace"
  type        = string
  default     = "AWS/Lambda"
}

variable "cloudwatch_alarm_statistics" {
  description = "The CloudWatch Alarm statistics"
  type        = string
  default     = "Average"
}

variable "cloudwatch_metric_name" {
  type        = string
  description = <<EOT
  The CloudWatch Metric Name.

  Options:
  - Duration 
  - Errors
  - Invocations
  - Throttles
  - ConcurrentExecutions

  Default: Duration
  EOT
  default     = "Duration"

  validation {
    condition     = can(regex("^Duration$|^Errors$|^Invocations$|^Throttles$|^ConcurrentExecutions$", var.cloudwatch_metric_name))
    error_message = "Err: CloudWatch Metric Name is not valid."
  }
}

variable "cloudwatch_alarm_period" {
  description = "The CloudWatch Alarm period in seconds"
  type        = number
  default     = 900
}

variable "cloudwatch_alarm_evaluation_period" {
  description = "The CloudWatch Alarm evaluation period"
  type        = number
  default     = 2
}

variable "cloudwatch_alarm_comparison_operator" {
  description = "The CloudWatch Alarm comparison operator"
  type        = string
  default     = "GreaterThanOrEqualToThreshold"
}

variable "cloudwatch_alarm_threshold" {
  description = "The CloudWatch Alarm threshold"
  type        = number
  default     = 10
}

variable "cloudwatch_alarm_description" {
  description = "The CloudWatch Alarm description"
  type        = string
  default     = ""
}

variable "datapoints_to_alarm" {
  description = "The CloudWatch Alarm datapoints to alarm"
  type        = number
  default     = 1
}
######################################## SNS Topic #################################################
variable "sns_topic_arn" {
  description = "The arn of the SNS Topic"
  type        = string
  default     = "arn:aws:sns:us-east-1:111111111111:sns-topic-name"
}
######################################## Local Variables ###########################################
locals {
  tags = tomap({
    Environment = var.environment_name
    ProjectName = var.project_name
  })
}

locals {
  cloudwatch_alarm_name = "${var.lambda_function_base_name}-${lower(var.cloudwatch_metric_name)}-alarm-${var.environment_name}-${data.aws_region.current.name}"
}

locals {
  lambda_function_name = "${var.lambda_function_base_name}-${var.environment_name}-${data.aws_region.current.name}"
}
