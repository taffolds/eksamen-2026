output "service_url" {
  description = "Public URL of the ECS Express service"
  value       = aws_ecs_express_gateway_service.wishifai.ingress_paths[0].endpoint
}