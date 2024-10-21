output "lambda" {
    value = aws_lambda_function.object_read.arn
}

output "iam_role" {
    value = aws_iam_role.lambda_execution_role.arn
}