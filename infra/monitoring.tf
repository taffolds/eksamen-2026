resource "aws_cloudwatch_dashboard" "wishifai" {
  dashboard_name = "wishifai-${var.candidate_number}"
  dashboard_body = <<DASHBOARD

{
    "widgets": [
        {
            "type": "metric",
            "x": 0, "y": 0, "width": 12, "height": 6,
            "properties": {
                "title": "Images Analyzed (Business)",
                "metrics": [["wishifai-6", "images.analyzed.count"]],
                "period": 60,
                "stat": "Sum",
                "region": "eu-west-1"
            }
        },
        {
            "type": "metric",
            "x": 12, "y": 0, "width": 12, "height": 6,
            "properties": {
                "title": "Gift Suggestions Per Request (Business)",
                "metrics": [["wishifai-6", "gift.suggestions.count.max"]],
                "period": 60,
                "stat": "Sum",
                "region": "eu-west-1"
            }
        },
        {
            "type": "metric",
            "x": 0, "y": 6, "width": 12, "height": 6,
            "properties": {
                "title": "ECS CPU Utilization (Infrastructure)",
                "metrics": [["AWS/ECS", "CPUUtilization", "ServiceName", "wishifai-${var.candidate_number}", "ClusterName", "default"]],
                "period": 60,
                "stat": "Maximum",
                "region": "eu-west-1"
            }
        },
        {
            "type": "metric",
            "x": 12, "y": 6, "width": 12, "height": 6,
            "properties": {
                "title": "Rekognition + Bedrock Duration (Application)",
                "metrics": [
                    ["wishifai-6", "rekognition.detect_labels.duration.max"],
                    ["wishifai-6", "bedrock.converse.duration.max"]
                ],
                "period": 60,
                "stat": "Maximum",
                "region": "eu-west-1"
            }
        }
    ]
}
DASHBOARD
}

resource "aws_cloudwatch_metric_alarm" "too_many_suggestions" {
  alarm_name          = "wishifai-too-many-suggestions-${var.candidate_number}"
  alarm_description   = "Fires when Bedrock returns more than 5 gift suggestions"
  namespace           = "wishifai-6"
  metric_name         = "gift.suggestions.count.max"
  statistic           = "Maximum"
  period              = 60
  evaluation_periods  = 1
  threshold           = 5
  comparison_operator = "GreaterThanThreshold"
}

resource "aws_cloudwatch_metric_alarm" "slow_bedrock" {
  alarm_name          = "wishifai-slow-bedrock-${var.candidate_number}"
  alarm_description   = "Fires when Bedrock response time exceeds 10 seconds, indicating degraded LLM performance"
  namespace           = "wishifai-6"
  metric_name         = "bedrock.converse.duration.max"
  statistic           = "Maximum"
  period              = 60
  evaluation_periods  = 1
  threshold           = 10000
  comparison_operator = "GreaterThanThreshold"
}