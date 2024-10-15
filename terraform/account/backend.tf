terraform {
  backend "s3" {
    bucket         = "terraform-state-bucket"  # Replace with your S3 bucket name
    key            = "s3/${terraform.workspace}/terraform.tfstate"  # Workspace-specific state file
    region         = "us-east-1"  # Specify your AWS region
    dynamodb_table = "terraform-lock-table"  # DynamoDB table for state locking
    encrypt        = true  # Encrypt the state file
  }
}
