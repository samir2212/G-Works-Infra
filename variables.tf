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
  default = "eu-central-1"
}

variable "username" {
  type    = string
  default = "admin"
}

variable "az_list" {
  type    = list(any)
  default = ["eu-central-1a", "eu-central-1b"]
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
  default = "dev.env"
}

variable "ecs_php_app" {
  default = "php_app"
}

variable "php_app_image" {
  default = "414882576784.dkr.ecr.eu-central-1.amazonaws.com/php_app-prod:ecs-dev-test"
}
