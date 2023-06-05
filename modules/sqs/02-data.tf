## ---------------------------------------------------------------------------------------------------------------------
## Data Definition - SQS Module
## Modification History:
##   - 1.0.0    Jun 3,2023   -- Initial Version
## ---------------------------------------------------------------------------------------------------------------------

# AWS Region and Caller Identity
data "aws_region" "current" {}

data "aws_caller_identity" "current" {}

# SQS Policy Document
data "aws_iam_policy_document" "sqs_policy_document" {
  statement {
    sid    = "__owner_statement"
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = [data.aws_caller_identity.current.account_id]
    }

    actions   = ["SQS:*"]
    resources = [aws_sqs_queue.sqs_queue.arn]

  }
}