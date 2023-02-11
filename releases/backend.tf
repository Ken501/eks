// Configure terraform backend
terraform {
  backend "s3" {
    bucket = "kmartinez-projects"
    region = "us-east-1"
  }
}
