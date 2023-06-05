## ---------------------------------------------------------------------------------------------------------------------
## Output - Project Celosia
## Modification History:
##   - 1.0.0    Jun 3,2023   -- Initial Version
## ---------------------------------------------------------------------------------------------------------------------

######################################## Dynamodb Table ############################################
output "celosia_dynamodb_table_arn" {
  value = module.celosia_dynamodb.dynamodb_table_arn
}

output "celosia_dynamodb_table_id" {
  value = module.celosia_dynamodb.dynamodb_table_id
}

output "celosia_dynamodb_table_tags_all" {
  value = module.celosia_dynamodb.dynamodb_table_tags_all
}
######################################## SQS Queue #################################################
output "celosia_sqs_queue_arn" {
  value = module.celosia_sqs.sqs_queue_arn
}

output "celosia_sqs_queue_id" {
  value = module.celosia_sqs.sqs_queue_id
}

output "celosia_sqs_queue_url" {
  value = module.celosia_sqs.sqs_queue_url
}

output "celosia_sqs_queue_tags_all" {
  value = module.celosia_sqs.sqs_topic_tags_all
}
######################################## SNS Topic #################################################
output "celosia_sns_topic_arn" {
  value = module.celosia_sns.sns_topic_arn
}

output "celosia_sns_topic_display_name" {
  value = module.celosia_sns.sns_topic_display_name
}

output "celosia_sns_topic_id" {
  value = module.celosia_sns.sns_topic_id
}

output "celosia_sns_topic_owner" {
  value = module.celosia_sns.sns_topic_owner
}

output "celosia_sns_topic_tags_all" {
  value = module.celosia_sns.sns_topic_tags_all
}
######################################## SNS Subscription ##########################################
output "celosia_sns_topic_subscription_arn" {
  value = module.celosia_sns.sns_topic_subscription_arn
}
######################################## Lambda IAM Role ###########################################
output "celosia_lambda_iam_role_arn" {
  value = module.celosia_iam_role.lambda_iam_role_arn
}
######################################## Step Function IAM Role ####################################
output "celosia_sf_iam_role_arn" {
  value = module.celosia_iam_role.sf_iam_role_arn
}
######################################## Lambda Function ###########################################
output "celosia_lambda_arn" {
  value = module.celosia_lambda_function.lambda_function_arn
}
######################################## Step Function #############################################
output "celosia_step_function_arn" {
  value = module.celosia_step_function.step_function_arn

}
######################################## Lambda Alarm ##############################################
#--------------------------------------- Duraion **Starts ------------------------------------------
output "celosia_lambda_duration_alarm_id" {
  value = module.celosia_lambda_duration_alarm.alarm_id
}

output "celosia_lambda_duration_alarm_arn" {
  value = module.celosia_lambda_duration_alarm.alarm_arn
}

output "celosia_lambda_duration_alarm_tags_all" {
  value = module.celosia_lambda_duration_alarm.alarm_tags_all
}

output "celosia_lambda_duration_alarm_dimensions" {
  value = module.celosia_lambda_duration_alarm.alarm_dimensions
}

output "celosia_lambda_duration_alarm_metric_name" {
  value = module.celosia_lambda_duration_alarm.alarm_metric_name
}

output "celosia_lambda_duration_alarm_namespace" {
  value = module.celosia_lambda_duration_alarm.alarm_namespace
}

output "celosia_lambda_duration_alarm_period" {
  value = module.celosia_lambda_duration_alarm.alarm_period
}

output "celosia_lambda_duration_alarm_statistic" {
  value = module.celosia_lambda_duration_alarm.alarm_statistic
}

output "celosia_lambda_duration_alarm_unit" {
  value = module.celosia_lambda_duration_alarm.alarm_unit
}
#--------------------------------------- Duration **Ends -------------------------------------------
#--------------------------------------- Errors **Starts -------------------------------------------
output "celosia_lambda_errors_alarm_id" {
  value = module.celosia_lambda_errors_alarm.alarm_id
}

output "celosia_lambda_errors_alarm_arn" {
  value = module.celosia_lambda_errors_alarm.alarm_arn
}

output "celosia_lambda_errors_alarm_tags_all" {
  value = module.celosia_lambda_errors_alarm.alarm_tags_all
}

output "celosia_lambda_errors_alarm_dimensions" {
  value = module.celosia_lambda_errors_alarm.alarm_dimensions
}

output "celosia_lambda_errors_alarm_metric_name" {
  value = module.celosia_lambda_errors_alarm.alarm_metric_name
}

output "celosia_lambda_errors_alarm_namespace" {
  value = module.celosia_lambda_errors_alarm.alarm_namespace
}

output "celosia_lambda_errors_alarm_period" {
  value = module.celosia_lambda_errors_alarm.alarm_period
}

output "celosia_lambda_errors_alarm_statistic" {
  value = module.celosia_lambda_errors_alarm.alarm_statistic
}

output "celosia_lambda_errors_alarm_unit" {
  value = module.celosia_lambda_errors_alarm.alarm_unit
}
#--------------------------------------- Errors **Ends ---------------------------------------------
#--------------------------------------- Invocations **Starts --------------------------------------
output "celosia_lambda_invocations_alarm_id" {
  value = module.celosia_lambda_invocations_alarm.alarm_id
}

output "celosia_lambda_invocations_alarm_arn" {
  value = module.celosia_lambda_invocations_alarm.alarm_arn
}

output "celosia_lambda_invocations_alarm_tags_all" {
  value = module.celosia_lambda_invocations_alarm.alarm_tags_all
}

output "celosia_lambda_invocations_alarm_dimensions" {
  value = module.celosia_lambda_invocations_alarm.alarm_dimensions
}

output "celosia_lambda_invocations_alarm_metric_name" {
  value = module.celosia_lambda_invocations_alarm.alarm_metric_name
}

output "celosia_lambda_invocations_alarm_namespace" {
  value = module.celosia_lambda_invocations_alarm.alarm_namespace
}

output "celosia_lambda_invocations_alarm_period" {
  value = module.celosia_lambda_invocations_alarm.alarm_period
}

output "celosia_lambda_invocations_alarm_statistic" {
  value = module.celosia_lambda_invocations_alarm.alarm_statistic
}

output "celosia_lambda_invocations_alarm_unit" {
  value = module.celosia_lambda_invocations_alarm.alarm_unit
}
#--------------------------------------- Invocations **Ends ----------------------------------------
#--------------------------------------- Executions **Starts ----------------------------------------
output "celosia_lambda_executions_alarm_id" {
  value = module.celosia_lambda_executions_alarm.alarm_id
}

output "celosia_lambda_executions_alarm_arn" {
  value = module.celosia_lambda_executions_alarm.alarm_arn
}

output "celosia_lambda_executions_alarm_tags_all" {
  value = module.celosia_lambda_executions_alarm.alarm_tags_all
}

output "celosia_lambda_executions_alarm_dimensions" {
  value = module.celosia_lambda_executions_alarm.alarm_dimensions
}

output "celosia_lambda_executions_alarm_metric_name" {
  value = module.celosia_lambda_executions_alarm.alarm_metric_name
}

output "celosia_lambda_executions_alarm_namespace" {
  value = module.celosia_lambda_executions_alarm.alarm_namespace
}

output "celosia_lambda_executions_alarm_period" {
  value = module.celosia_lambda_executions_alarm.alarm_period
}

output "celosia_lambda_executions_alarm_statistic" {
  value = module.celosia_lambda_executions_alarm.alarm_statistic
}

output "celosia_lambda_executions_alarm_unit" {
  value = module.celosia_lambda_executions_alarm.alarm_unit
}
#--------------------------------------- Executions **Ends ------------------------------------------
#--------------------------------------- Throttles **Starts ----------------------------------------
output "celosia_lambda_throttles_alarm_id" {
  value = module.celosia_lambda_throttles_alarm.alarm_id
}

output "celosia_lambda_throttles_alarm_arn" {
  value = module.celosia_lambda_throttles_alarm.alarm_arn
}

output "celosia_lambda_throttles_alarm_tags_all" {
  value = module.celosia_lambda_throttles_alarm.alarm_tags_all
}

output "celosia_lambda_throttles_alarm_dimensions" {
  value = module.celosia_lambda_throttles_alarm.alarm_dimensions
}

output "celosia_lambda_throttles_alarm_metric_name" {
  value = module.celosia_lambda_throttles_alarm.alarm_metric_name
}

output "celosia_lambda_throttles_alarm_namespace" {
  value = module.celosia_lambda_throttles_alarm.alarm_namespace
}

output "celosia_lambda_throttles_alarm_period" {
  value = module.celosia_lambda_throttles_alarm.alarm_period
}

output "celosia_lambda_throttles_alarm_statistic" {
  value = module.celosia_lambda_throttles_alarm.alarm_statistic
}

output "celosia_lambda_throttles_alarm_unit" {
  value = module.celosia_lambda_throttles_alarm.alarm_unit
}
#--------------------------------------- Throttles **Ends ------------------------------------------