# resource "aws_cloudwatch_event_rule" "EventsRule" {
#   name          = "CWL-RETENTION-AddRetentionPolicyRule"
#   description   = "Triggers Lambda which configures log group retention policy"
#   event_pattern = <<EOF
# {
#   "detail-type": ["AWS API Call via CloudTrail"],
#   "source": ["aws.logs"],
#   "detail": {
#     "eventSource": ["logs.amazonaws.com"],
#     "eventName": ["CreateLogGroup"]
#   }
# }
# EOF
# }

# resource "aws_cloudwatch_event_target" "CloudWatchEventTarget" {
#   rule      = aws_cloudwatch_event_rule.EventsRule.name
#   arn       = aws_lambda_function.cwl_retention_logs.arn
#   target_id = "SendToLambda"
# }