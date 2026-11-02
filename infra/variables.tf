variable "region" {
  description = "AWS region"
  type        = string
  default     = "eu-west-1"
}

variable "candidate_number" {
  description = "Exam candidate number"
  type        = string
  default     = "6"
}

variable "image_tag" {
  description = "Docker image tag to deploy"
  type        = string
  default     = "latest"
}

variable "bucket_name" {
  description = "S3 bucket for image uploads"
  type        = string
  default     = "wishifai-uploads-6"
}