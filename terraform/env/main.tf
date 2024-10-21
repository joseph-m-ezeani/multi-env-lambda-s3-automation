module "lambda" {
    source = "../modules/lambda"
    bucket = var.bucket
    bucket_arn = var.bucket_arn
    timeout = var.timeout
    runtime = var.runtime
    env = terraform.workspace
    access_key = var.access_key
    secret_key = var.secret_key
}