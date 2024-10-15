resource "aws_s3_bucket" "this" {
  bucket = var.bucket_name

  # Enable versioning
  versioning {
    enabled = var.versioning
  }

}
