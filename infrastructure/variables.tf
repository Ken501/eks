// Common Variables

variable "AWS_ACCESS_KEY_ID" {
  description = "AWS Access key"
  type = string
}

variable "AWS_SECRET_ACCESS_KEY" {
  description = "AWS Secret key"
  type = string
}

variable "AWS_REGION" {
  description = "AWS preferred region"
  type = string
}

variable "app_name" {
  description = "Application name"
  type = string
}

variable "environment" {
  description = "Application lifecycle stage"
  type = string
}

variable "additional_tags" {
  description = "Tags used to identify the project and other details"
  default     = {}
  type        = map(string)
}

// Backend variables

variable "backend_bucket" {
  description = "Terraform backend bucket name"
}

// Cluster variables
variable "kubernetes_version" {
  description = "Kubernetes version"
  type = string
  default = "1.24"
}

variable "ingress_controller_version" {
  description = "AWS Ingress controller version"
  type = string
  default = "1.4.1"
}

variable "coredns_addon_version" {
  description = "CoreDNS Cluster CNI addon version"
  type = string
  default = "v1.8.7-eksbuild.3"
}