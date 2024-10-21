module "s3" {
    source = "../modules/s3"
    bucket_name = var.bucket_name
    access_key = var.access_key
    secret_key = var.secret_key
}