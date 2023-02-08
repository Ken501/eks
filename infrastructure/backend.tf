// Configure terraform backend
terraform {
  backend "s3" {
    bucket = "kmartinez-projects"
    key    = "infrastructure/k8s"
    region = "us-east-1"
  }
}
