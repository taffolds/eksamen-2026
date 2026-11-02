resource "aws_s3_bucket" "wishifai_images" {
  bucket = var.bucket_name
}

resource "aws_ecs_express_gateway_service" "wishifai" {
  service_name            = "wishifai-${var.candidate_number}"
  execution_role_arn      = "arn:aws:iam::244530008913:role/ecsTaskExecutionRole"
  infrastructure_role_arn = "arn:aws:iam::244530008913:role/service-role/ecsInfrastructureRoleForExpressServices"
  task_role_arn           = aws_iam_role.wishifai_task_role.arn
  health_check_path       = "/actuator/health"

  primary_container {
    image          = "244530008913.dkr.ecr.eu-west-1.amazonaws.com/doing-some-devops:${var.image_tag}"
    container_port = 8080

    environment {
      name  = "S3_BUCKET"
      value = var.bucket_name
    }
  }
}