## ---------------------------------------------------------------------------------------------------------------------
## Output - IAM Role Module
## Modification History:
##   - 1.0.0    Jun 3,2023   -- Initial Version
## ---------------------------------------------------------------------------------------------------------------------

output "lambda_iam_role_arn" {
  value = aws_iam_role.lambda-iam-role.arn
}

output "sf_iam_role_arn" {
  value = aws_iam_role.sf-iam-role.arn
}