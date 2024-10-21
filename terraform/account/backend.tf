terraform {
  backend "s3" {
    bucket         = "terraform-state-bucket-162435093709"  # Replace with your S3 bucket name
    key            = "s3/terraform.tfstate"  # Workspace-specific state file
    region         = "us-east-1"  # Specify your AWS region
    dynamodb_table = "terraform-lock-table"  # DynamoDB table for state locking
    encrypt        = true  # Encrypt the state file
  }
}
