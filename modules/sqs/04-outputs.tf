## ---------------------------------------------------------------------------------------------------------------------
## Output - SQS Module
## Modification History:
##   - 1.0.0    Jun 3,2023   -- Initial Version
## ---------------------------------------------------------------------------------------------------------------------

######################################## AWS REGION ################################################
output "current_region" {
  value = data.aws_region.current.name
}

output "current_region_description" {
  value = data.aws_region.current.description
}
######################################## SQS Queue #################################################
output "sqs_queue_arn" {
  value = aws_sqs_queue.sqs_queue.arn
}

output "sqs_queue_id" {
  value = aws_sqs_queue.sqs_queue.id
}

output "sqs_queue_url" {
  value = aws_sqs_queue.sqs_queue.url
}

output "sqs_topic_tags_all" {
  value = aws_sqs_queue.sqs_queue.tags_all
}


