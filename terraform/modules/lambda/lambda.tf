# Lambda function to trigger a AWS CodeBuild project
resource "aws_lambda_function" "object_read" {
  function_name = "${var.function}-${var.env}"
  description   = "Comprises of logic for configuring log retention policy for log group(s)"
  handler       = "lambda_function.lambda_handler"
  memory_size   = 1024
  role          = aws_iam_role.lambda_execution_role.arn
  runtime       = var.runtime
  filename      = "${path.module}/lambda/lambda.zip"
  timeout       = var.timeout
}

data "archive_file" "lambda" {
  type        = "zip"
  source_file = "${path.module}/lambda/lambda_function.py"
  output_path = "${path.module}/lambda/lambda.zip"
}


resource "aws_s3_bucket_notification" "bucket_notification" {
  count = terraform.workspace == "stg" ? 1 : 0
  bucket = var.bucket

  lambda_function {
    lambda_function_arn = aws_lambda_function.object_read.arn
    events              = ["s3:ObjectCreated:*"] 
    filter_prefix       = "data/${var.env}/" # Trigger on object creation
  }
  depends_on = [aws_lambda_function.object_read]
}

resource "aws_lambda_permission" "PermissionForEventsToInvokeLambda" {
  statement_id  = "AllowS3Invoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.object_read.function_name
  principal     = "s3.amazonaws.com"
  source_arn = var.bucket_arn
}

# Lambda execution role
resource "aws_iam_role" "lambda_execution_role" {
  name = "cwl-retention-lambda-execution-role-${terraform.workspace}-${local.account_id}"
  path = "/"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      },
    ]
  })

  inline_policy {
    name = "LambdaPolicy"
    policy = jsonencode({
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Action" : [
            "logs:PutRetentionPolicy",
            "logs:DescribeLogGroups",
            "logs:DescribeLogStreams",
            "config:PutEvaluations"
          ],
          "Resource" : [
            "*"
          ],
          "Effect" : "Allow"
        },
      ]
    })
  }

  managed_policy_arns = [
    "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
  ]
}

resource "aws_iam_policy" "lambda_policy" {
  name        = "lambda-s3-policy-${terraform.workspace}-${local.account_id}"
  description = "Policy for Lambda to access S3"
  
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action   = [
        "s3:GetObject",
        "s3:*"
      ]
      Effect   = "Allow"
      Resource = [
         "*"
      ]
    }]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_policy_attachment" {
  role       = aws_iam_role.lambda_execution_role.name
  policy_arn = aws_iam_policy.lambda_policy.arn
}

