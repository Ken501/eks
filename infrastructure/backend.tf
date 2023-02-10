// Configure terraform backend
terraform {
  backend "s3" {
    bucket = "kmartinez-projects"
    key    = "infrastructure/us-east-1"
    region = "us-east-1"
  }
}
