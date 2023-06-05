## ---------------------------------------------------------------------------------------------------------------------
## Variable Definition - Project Celosia
## Modification History:
##   - 1.0.0    Jun 3,2023   -- Initial Version
## ---------------------------------------------------------------------------------------------------------------------

terraform {
  backend "s3" {
    bucket  = "subhamay-tf-remote-state-us-east-1/" // Bucket where to SAVE Terraform State
    key     = "0069-celosia/prod/terraform.tfstate" // Object name in the bucket to SAVE Terraform State
    region  = "us-east-1"                           // Region where bucket created
    encrypt = true
  }
}

provider "aws" {
  region = "us-east-1"

  # Make it faster by skipping something
  skip_credentials_validation = true
  skip_requesting_account_id  = true
}