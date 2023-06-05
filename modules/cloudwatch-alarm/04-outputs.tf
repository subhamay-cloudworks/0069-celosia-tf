## ---------------------------------------------------------------------------------------------------------------------
## Output - CloudWatch Alarm Module
## Modification History:
##   - 1.0.0    Jun 3,2023   -- Initial Version
## ---------------------------------------------------------------------------------------------------------------------

output "alarm_id" {
  value = aws_cloudwatch_metric_alarm.cloudwatch_metric_alarm.id
}

output "alarm_arn" {
  value = aws_cloudwatch_metric_alarm.cloudwatch_metric_alarm.arn
}

output "alarm_tags_all" {
  value = aws_cloudwatch_metric_alarm.cloudwatch_metric_alarm.tags_all
}

output "alarm_dimensions" {
  value = aws_cloudwatch_metric_alarm.cloudwatch_metric_alarm.dimensions
}

output "alarm_metric_name" {
  value = aws_cloudwatch_metric_alarm.cloudwatch_metric_alarm.metric_name
}

output "alarm_namespace" {
  value = aws_cloudwatch_metric_alarm.cloudwatch_metric_alarm.namespace
}

output "alarm_period" {
  value = aws_cloudwatch_metric_alarm.cloudwatch_metric_alarm.period
}

output "alarm_statistic" {
  value = aws_cloudwatch_metric_alarm.cloudwatch_metric_alarm.statistic
}

output "alarm_unit" {
  value = aws_cloudwatch_metric_alarm.cloudwatch_metric_alarm.unit
}