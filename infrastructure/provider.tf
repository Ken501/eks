terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region     = var.AWS_REGION
  access_key = var.AWS_ACCESS_KEY_ID
  secret_key = var.AWS_SECRET_ACCESS_KEY
}

provider "kubernetes" {
  config_path    = "~/.kube/config"
}

resource "kubernetes_namespace" "namespace" {
  metadata {
    name = "${var.environment}-${var.app_name}-ns-${var.AWS_REGION}"
  }
}