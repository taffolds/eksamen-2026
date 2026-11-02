resource "aws_iam_role" "wishifai_task_role" {
  name = "wishifai-task-role-6"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect    = "Allow"
        Principal = { Service = "ecs-tasks.amazonaws.com" }
        Action    = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy" "wishifai_task_policy" {
  name = "wishifai-task-policy-6"
  role = aws_iam_role.wishifai_task_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "rekognition:DetectLabels",
          "bedrock:InvokeModel",
          "s3:PutObject",
          "s3:GetObject",
          "cloudwatch:PutMetricData"
        ]
        Resource = "*"
      }
    ]
  })
}