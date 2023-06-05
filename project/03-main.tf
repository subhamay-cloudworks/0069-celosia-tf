## ---------------------------------------------------------------------------------------------------------------------
## Project Celosia - Main 
## Modification History:
##   - 1.0.0    Jun 3,2023   -- Initial Version
## This project will deploy the following resources:

## A Lambda function for seeding the DynamoDB table
## An Amazon SQS queue
## A SNS Topic with email subscription
## Five CloudWatch Alarms
## A DynamoDB table
## A Step Function
## ---------------------------------------------------------------------------------------------------------------------

## Kinesis Data Stream
module "celosia_dynamodb" {
  source                   = "../modules/dynamodb"
  project_name             = var.project_name
  environment_name         = var.environment_name
  dynamodb_table_base_name = var.dynamodb_table_base_name
  partition_key            = var.partition_key
  partition_key_data_type  = var.partition_key_data_type
  kms_key_arn              = var.kms_key_arn
}

## SQS Queue
module "celosia_sqs" {
  source                    = "../modules/sqs"
  project_name              = var.project_name
  environment_name          = var.environment_name
  sqs_queue_base_name       = var.sqs_queue_base_name
  delay_seconds             = var.delay_seconds
  max_message_size          = var.max_message_size
  message_retention_seconds = var.message_retention_seconds
  receive_wait_time_seconds = var.receive_wait_time_seconds
  kms_key_alias             = var.kms_key_alias
}

## SNS Topic with subscription
module "celosia_sns" {
  source                 = "../modules/sns"
  sns_topic_base_name    = var.sns_topic_base_name
  sns_topic_display_name = var.sns_topic_display_name
  kms_key_alias          = var.kms_key_alias
  sns_subscription_email = var.sns_subscription_email
}

## Lambda / Step Function IAM Role
module "celosia_iam_role" {
  source                    = "../modules/iam-role"
  project_name              = var.project_name
  environment_name          = var.environment_name
  lambda_iam_role_name      = var.lambda_iam_role_name
  lambda_iam_policy_name    = var.lambda_iam_policy_name
  sf_iam_role_name          = var.sf_iam_role_name
  sf_iam_policy_name        = var.sf_iam_policy_name
  lambda_function_base_name = var.lambda_function_base_name
  dynamodb_table_base_name  = var.dynamodb_table_base_name
  sqs_queue_base_name       = var.sqs_queue_base_name
  kms_key_arn               = var.kms_key_arn
}

# Seed DynamoDB Table Lambda
module "celosia_lambda_function" {
  source                         = "../modules/lambda"
  project_name                   = var.project_name
  environment_name               = var.environment_name
  lambda_function_base_name      = var.lambda_function_base_name
  lambda_function_description    = var.lambda_function_description
  iam_role_name                  = module.celosia_iam_role.lambda_iam_role_arn
  memory_size                    = var.memory_size
  timeout                        = var.timeout
  runtime                        = var.runtime
  dynamodb_table_base_name       = var.dynamodb_table_base_name
  reserved_concurrent_executions = var.reserved_concurrent_executions
}

## State Machine
module "celosia_step_function" {
  source              = "../modules/step-function"
  project_name        = var.project_name
  environment_name    = var.environment_name
  sf_iam_role_arn     = module.celosia_iam_role.sf_iam_role_arn
  lambda_function_arn = module.celosia_lambda_function.lambda_function_arn
  dynamodb_table_name = module.celosia_dynamodb.dynamodb_table_id
  sqs_queue_url       = module.celosia_sqs.sqs_queue_url
}

# Lambda duration alarm
module "celosia_lambda_duration_alarm" {
  source                               = "../modules/cloudwatch-alarm"
  lambda_function_base_name            = var.lambda_function_base_name
  cloudwatch_alarm_namespace           = "AWS/Lambda"
  cloudwatch_alarm_statistics          = "Average"
  cloudwatch_metric_name               = "Duration"
  cloudwatch_alarm_period              = 900
  datapoints_to_alarm                  = 1
  cloudwatch_alarm_evaluation_period   = 1
  cloudwatch_alarm_comparison_operator = "GreaterThanOrEqualToThreshold"
  cloudwatch_alarm_threshold           = 500
  cloudwatch_alarm_description         = "Celosia - Alarm for Lambda function duration"
  sns_topic_arn                        = module.celosia_sns.sns_topic_arn
}

# Lambda errors alarm
module "celosia_lambda_errors_alarm" {
  source                               = "../modules/cloudwatch-alarm"
  lambda_function_base_name            = var.lambda_function_base_name
  cloudwatch_alarm_namespace           = "AWS/Lambda"
  cloudwatch_alarm_statistics          = "Sum"
  cloudwatch_metric_name               = "Errors"
  cloudwatch_alarm_period              = 900
  datapoints_to_alarm                  = 1
  cloudwatch_alarm_evaluation_period   = 1
  cloudwatch_alarm_comparison_operator = "GreaterThanOrEqualToThreshold"
  cloudwatch_alarm_threshold           = 2
  cloudwatch_alarm_description         = "Celosia - Alarm for number Lambda function errors"
  sns_topic_arn                        = module.celosia_sns.sns_topic_arn
}

# Lambda invocations alarm
module "celosia_lambda_invocations_alarm" {
  source                               = "../modules/cloudwatch-alarm"
  lambda_function_base_name            = var.lambda_function_base_name
  cloudwatch_alarm_namespace           = "AWS/Lambda"
  cloudwatch_alarm_statistics          = "Sum"
  cloudwatch_metric_name               = "Invocations"
  cloudwatch_alarm_period              = 900
  datapoints_to_alarm                  = 1
  cloudwatch_alarm_evaluation_period   = 1
  cloudwatch_alarm_comparison_operator = "GreaterThanOrEqualToThreshold"
  cloudwatch_alarm_threshold           = 5
  cloudwatch_alarm_description         = "Celosia - Alarm for number Lambda function invocations"
  sns_topic_arn                        = module.celosia_sns.sns_topic_arn
}

# Lambda throttles alarm
module "celosia_lambda_throttles_alarm" {
  source                               = "../modules/cloudwatch-alarm"
  lambda_function_base_name            = var.lambda_function_base_name
  cloudwatch_alarm_namespace           = "AWS/Lambda"
  cloudwatch_alarm_statistics          = "Sum"
  cloudwatch_metric_name               = "Throttles"
  cloudwatch_alarm_period              = 600
  datapoints_to_alarm                  = 1
  cloudwatch_alarm_evaluation_period   = 1
  cloudwatch_alarm_comparison_operator = "GreaterThanOrEqualToThreshold"
  cloudwatch_alarm_threshold           = 3
  cloudwatch_alarm_description         = "Celosia - Alarm for Lambda function throttles"
  sns_topic_arn                        = module.celosia_sns.sns_topic_arn
}

# Lambda concurrent execution alarm
module "celosia_lambda_executions_alarm" {
  source                               = "../modules/cloudwatch-alarm"
  lambda_function_base_name            = var.lambda_function_base_name
  cloudwatch_alarm_namespace           = "AWS/Lambda"
  cloudwatch_alarm_statistics          = "Sum"
  cloudwatch_metric_name               = "ConcurrentExecutions"
  cloudwatch_alarm_period              = 60
  datapoints_to_alarm                  = 1
  cloudwatch_alarm_evaluation_period   = 1
  cloudwatch_alarm_comparison_operator = "GreaterThanOrEqualToThreshold"
  cloudwatch_alarm_threshold           = 3
  cloudwatch_alarm_description         = "Celosia - Alarm for Lambda concurrent executions"
  sns_topic_arn                        = module.celosia_sns.sns_topic_arn
}