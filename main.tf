terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

terraform {
  backend "s3" {
    bucket         = "g-works-terraform-state-prod"
    key            = "g-works01-prod/terraform.tfstate"
    dynamodb_table = "terraform-state-lock-dynamo-prod"
    region         = "eu-central-1"
  }
}

provider "aws" {
  region = var.aws_region
}
