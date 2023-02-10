locals {
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets = ["10.0.3.0/24", "10.0.4.0/24"]
  public_subnet_ids = [aws_subnet.public01.id, aws_subnet.public02.id]
  private_subnet_ids = [aws_subnet.private01.id, aws_subnet.private02.id]
  az = ["us-east-1a", "us-east-1b"]

  cluster_name = "${var.environment}-${var.app_name}-cluster-${var.AWS_REGION}"

  # Backend locals
  backend_bucket = "kmartinez-projects"
  key    = "${var.environment}/${var.app_name}/infrastructure/${var.AWS_REGION}"
  region = var.AWS_REGION

}