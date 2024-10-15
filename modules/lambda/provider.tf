terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region     = "us-east-1"
  access_key = "AKIASLUPC2TGT76YSWNJ"
  secret_key = "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"
}