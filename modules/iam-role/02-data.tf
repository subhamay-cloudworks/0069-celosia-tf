## ---------------------------------------------------------------------------------------------------------------------
## Data Definition - IAM Execution Role Module
## Modification History:
##   - 1.0.0    Jun 3,2023   -- Initial Version
## ---------------------------------------------------------------------------------------------------------------------

# AWS Region and Caller Identity
data "aws_region" "current" {}

data "aws_caller_identity" "current" {}

# Lambda IAM Policy Document
data "aws_iam_policy_document" "lambda-iam-policy-document" {
  statement {
    sid = "AllowCloudWatchLogStream"
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]
    resources = [
      "arn:aws:logs:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:log-group:/aws/lambda/${local.lambda_function_name}:*",
    ]
  }

  statement {
    sid = "AllowDynamoDBBatchWriteItem"
    actions = [
      "dynamodb:GetItem",
      "dynamodb:PutItem"
    ]
    resources = [
      "arn:aws:dynamodb:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:table/${local.dynamodb_table_name}",
    ]
  }

  dynamic "statement" {
    for_each = var.environment_name == "prod" || var.environment_name == "test" ? [true] : []
    content {
      sid = "AllowKMSDecryption"
      actions = [
        "kms:Decrypt",
        "kms:Encrypt",
        "kms:GenerateDataKey",
        "kms:GenerateDataKeyPair"
      ]
      resources = [var.kms_key_arn[data.aws_region.current.name]]
    }
  }
}


# Step Function IAM Policy Document
data "aws_iam_policy_document" "sf-iam-policy-document" {
  statement {
    sid = "AllowDynamoDBGetItem"
    actions = [
      "dynamodb:GetItem"
    ]
    resources = [
      "arn:aws:dynamodb:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:table/${local.dynamodb_table_name}"
    ]
  }

  statement {
    sid = "AllowSQSSendMessage"
    actions = [
      "sqs:SendMessage"
    ]
    resources = [
      "arn:aws:sqs:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:${local.sqs_queue_name}"
    ]
  }

  statement {
    sid = "AllowInvokeLambda"
    actions = [
      "lambda:InvokeFunction"
    ]
    resources = [
      "*"
    ]
  }

  dynamic "statement" {
    for_each = var.environment_name == "prod" || var.environment_name == "test" ? [true] : []
    content {
      sid = "AllowKMSDecryption"
      actions = [
        "kms:Decrypt",
        "kms:Encrypt",
        "kms:GenerateDataKey",
        "kms:GenerateDataKeyPair"
      ]
      resources = [var.kms_key_arn[data.aws_region.current.name]]
    }
  }
}