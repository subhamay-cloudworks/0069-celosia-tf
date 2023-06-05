## ---------------------------------------------------------------------------------------------------------------------
## SNS - Main 
## Modification History:
##   - 1.0.0    May 22,2023   -- Initial Version
## ---------------------------------------------------------------------------------------------------------------------

######################################## SNS Topic #################################################
resource "aws_sns_topic" "sns_topic" {
  name              = local.topic_name
  display_name      = var.sns_topic_display_name
  kms_master_key_id = (var.environment_name == "prod" || var.environment_name == "test") ? var.kms_key_alias : ""
  tags              = local.tags
}
######################################## SNS Subscription ##########################################
resource "aws_sns_topic_subscription" "sns_topic_target" {
  topic_arn = aws_sns_topic.sns_topic.arn
  protocol  = "email"
  for_each  = toset(var.sns_subscription_email)
  endpoint  = each.value
}