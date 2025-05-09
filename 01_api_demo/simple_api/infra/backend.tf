terraform {
  backend "s3" {
    bucket         = "simple-api-state-be"
    key            = "simple_api/terraform.tfstate"
    region         = "us-east-1"         
    encrypt        = true
    dynamodb_table = "terraform-locks"
    # profile      = "your-aws-cli-profile" # optional
  }
}
