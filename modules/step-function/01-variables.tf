## ---------------------------------------------------------------------------------------------------------------------
## Variable Definition - State Machine Module
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
######################################## DynamoDB Table ############################################
variable "sf_iam_role_arn" {
  description = "The Arn of the IAM role for the state machine."
  type        = string
  default     = ""
}
######################################## DynamoDB Table ############################################
variable "dynamodb_table_name" {
  description = "The name of the DynamoDB table"
  type        = string
  default     = "dynamodb-table-name"
}
######################################## Lambda Function ###########################################
variable "lambda_function_arn" {
  description = "The Arn of the lambda function"
  type        = string
  default     = ""
}
######################################## SQS Queue #################################################
variable "sqs_queue_url" {
  description = "The URL Of the SQS Queue"
  type        = string
  default     = ""
}
######################################## Local Variables ###########################################
locals {
  tags = tomap({
    Environment = var.environment_name
    ProjectName = var.project_name
  })
}

locals {
  step_function_name = "${var.project_name}-state-machine-${var.environment_name}-${data.aws_region.current.name}"
}

locals {
  definition_template = <<EOF
{
  "Comment": "An example of the Amazon States Language for reading messages from a DynamoDB table and sending them to SQS",
  "StartAt": "Seed the DynamoDB Table",
  "TimeoutSeconds": 3600,
  "States": {
    "Seed the DynamoDB Table": {
      "Type": "Task",
      "Resource": "${var.lambda_function_arn}:$LATEST",
      "ResultPath": "$.List",
      "Next": "For Loop Condition"
    },
    "For Loop Condition": {
      "Type": "Choice",
      "Choices": [
        {
          "Not": {
            "Variable": "$.List[0]",
            "StringEquals": "DONE"
          },
          "Next": "Read Next Message from DynamoDB"
        }
      ],
      "Default": "Succeed"
    },
    "Read Next Message from DynamoDB": {
      "Type": "Task",
      "Resource": "arn:aws:states:::dynamodb:getItem",
      "Parameters": {
        "TableName": "${var.dynamodb_table_name}",
        "Key": {
          "MessageId": {
            "S.$": "$.List[0]"
          }
        }
      },
      "ResultPath": "$.DynamoDB",
      "Next": "Send Message to SQS"
    },
    "Send Message to SQS": {
      "Type": "Task",
      "Resource": "arn:aws:states:::sqs:sendMessage",
      "Parameters": {
        "MessageBody.$": "$.DynamoDB.Item.Message.S",
        "QueueUrl": "${var.sqs_queue_url}"
      },
      "ResultPath": "$.SQS",
      "Next": "Pop Element from List"
    },
    "Pop Element from List": {
      "Type": "Pass",
      "Parameters": {
        "List.$": "$.List[1:]"
      },
      "Next": "For Loop Condition"
    },
    "Succeed": {
      "Type": "Succeed"
    }
  }
}
EOF
}
