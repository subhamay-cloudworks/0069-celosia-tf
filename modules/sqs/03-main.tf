## ---------------------------------------------------------------------------------------------------------------------
## SQS - Main 
## Modification History:
##   - 1.0.0    Jun 3,2023   -- Initial Version
## ---------------------------------------------------------------------------------------------------------------------

######################################## SQS Queue# ################################################
resource "aws_sqs_queue" "sqs_queue" {
  name                      = local.queue_name
  delay_seconds             = var.delay_seconds
  max_message_size          = var.max_message_size
  message_retention_seconds = var.message_retention_seconds
  receive_wait_time_seconds = var.receive_wait_time_seconds
  kms_master_key_id         = (var.environment_name == "prod" || var.environment_name == "test") ? var.kms_key_alias : ""
  tags                      = local.tags
}
######################################## SQS Queue Policy############################################
resource "aws_sqs_queue_policy" "sqs_queue_policy" {
  queue_url = aws_sqs_queue.sqs_queue.id
  policy    = data.aws_iam_policy_document.sqs_policy_document.json
}