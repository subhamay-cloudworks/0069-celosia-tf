## ---------------------------------------------------------------------------------------------------------------------
## IAM Role and Policy - Main 
## Modification History:
##   - 1.0.0    Jun 3,2023   -- Initial Version
## ---------------------------------------------------------------------------------------------------------------------

######################################## Lambda IAM Role ###########################################
resource "aws_iam_role" "lambda-iam-role" {
  name        = var.lambda_iam_role_name
  description = "Celosia Lambda execution role"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = "LambdaTrustPolicy"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      },
    ]
  })

  tags = local.tags
}
######################################## Lambda IAM Policy #########################################
resource "aws_iam_policy" "lambda-iam-policy" {
  name        = var.lambda_iam_policy_name
  path        = "/"
  description = "Celosia Lambda execution policy"


  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = data.aws_iam_policy_document.lambda-iam-policy-document.json
}
######################################## Lambda IAM Role / Policy attachment #######################
resource "aws_iam_role_policy_attachment" "lambda-iam-role-policy-attachment" {
  depends_on = [aws_iam_role.lambda-iam-role, aws_iam_policy.lambda-iam-policy]

  role       = aws_iam_role.lambda-iam-role.name
  policy_arn = aws_iam_policy.lambda-iam-policy.arn
}
######################################## State Machine IAM Role ####################################
resource "aws_iam_role" "sf-iam-role" {
  name        = var.sf_iam_role_name
  description = "Celosia state machine IAM role"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = "StepFunctionTrustPolicy"
        Principal = {
          Service = "states.amazonaws.com"
        }
      },
    ]
  })

  tags = local.tags
}
######################################## State Machine IAM Policy ##################################
resource "aws_iam_policy" "sf-iam-policy" {
  name        = var.sf_iam_policy_name
  path        = "/"
  description = "Celosia Step Function execution policy"


  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = data.aws_iam_policy_document.sf-iam-policy-document.json
}
######################################## State machine IAM Role / Policy attachment ################
resource "aws_iam_role_policy_attachment" "sf-iam-role-policy-attachment" {
  depends_on = [aws_iam_role.sf-iam-role, aws_iam_policy.sf-iam-policy]

  role       = aws_iam_role.sf-iam-role.name
  policy_arn = aws_iam_policy.sf-iam-policy.arn
}
