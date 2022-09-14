
resource "aws_s3_bucket" "ta_backend_bucket" { #terraform name for bucket should be with underscore
  bucket = "ta-terraform-tfstate-439272626435" # this is my bucket name in aws. doesnt need to be with underscore

  lifecycle {
    prevent_destroy = true # this line prevent s3 bucket to be deleted
  }

  tags = {
    Name  = "ta-terraform-tfstate-439272626435" 
    Environment = "Test"
    team = "Talent-Academy"
    owner ="Nastaran"
  }
}
#this line create a new bucket acl which helps for access control for giving permission for the first bucket
#resource "aws_s3_bucket_acl" "ta_backend_bucket" {
 # bucket = "aws_s3_bucket"
  #acl    = "private"
#}
#this line create another s3 bucket that holds different versions of first s3 bucket files
resource "aws_s3_bucket_versioning" "version_my_bucket" { 
  bucket = aws_s3_bucket.ta_backend_bucket.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_dynamodb_table" "terraform_lock_tbl" {
  name           = "terraform-lock"
  read_capacity  = 1
  write_capacity = 1
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags           = {
    Name = "terraform-lock"
  }
}