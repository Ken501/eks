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
  default = "kmartinez-projects"
}