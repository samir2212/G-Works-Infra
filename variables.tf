variable "project" {
  default = "g-works"
}

variable "env" {
  description = "Environment name"
  type        = string
  default     = "prod"
}

variable "aws_region" {
  type    = string
  default = "eu-north-1"
}

variable "username" {
  type    = string
  default = "admin"
}

variable "api-domain-name" {
  default = ["api.talovisio.fi"]
}

variable "domain-name" {
  default = ["beta.talovisio.fi"]
}

variable "az_list" {
  type    = list(any)
  default = ["eu-north-1a", "eu-north-1b"]
}

variable "vpc_cidr" {
  type    = string
  default = "10.200.0.0/16"
}

variable "vpc_cidr_public_a" {
  type    = string
  default = "10.200.1.0/24"
}

variable "vpc_cidr_public_b" {
  type    = string
  default = "10.200.2.0/24"
}

variable "vpc_cidr_private_a" {
  type    = string
  default = "10.200.11.0/24"
}

variable "vpc_cidr_private_b" {
  type    = string
  default = "10.200.12.0/24"
}

variable "env_file" {
  type    = string
  default = "prod.env"
}

variable "ecs_php_app" {
  default = "php_app"
}

variable "php_app_image" {
  default = "141204083709.dkr.ecr.eu-north-1.amazonaws.com/php_app-prod:master_32fb3b7b"
}
