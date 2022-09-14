terraform {
  backend "s3" {
    bucket = "ta-terraform-tfstate-439272626435"
    key    = "sprint1/week2/training-terraform/terraform.tfstates"
    dynamodb_table = "terraform-lock"

  }
}