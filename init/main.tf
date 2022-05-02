terraform {
  backend "s3" {
    bucket         = "g-works-terraform-state-prod"
    key            = "initial_setup/terraform.tfstate"
    dynamodb_table = "terraform-state-lock-dynamo-prod"
    region         = "eu-central-1"
    encrypt        = true
  }
}

variable "env" {
  description = "Environment name"
  type        = string
  default     = "prod"
}

resource "aws_s3_bucket" "g-works-terraform-state" {
  bucket = "g-works-terraform-state-${var.env}"
  tags = {
    Name        = "g-works-terraform-state"
    Environment = "${var.env}"
  }
}

resource "aws_s3_bucket_versioning" "g-works-terraform-state" {
  bucket = aws_s3_bucket.g-works-terraform-state.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "g-works-terraform-state" {
  bucket = aws_s3_bucket.g-works-terraform-state.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "g-works-terraform-state" {
  bucket                  = aws_s3_bucket.g-works-terraform-state.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_ownership_controls" "g-works-terraform-state" {
  bucket = aws_s3_bucket.g-works-terraform-state.id

  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}

resource "aws_s3_bucket_acl" "g-works-terraform-state" {
  bucket = aws_s3_bucket.g-works-terraform-state.id
  acl    = "private"
}

resource "aws_dynamodb_table" "dynamodb-terraform-state-lock" {
  name         = "terraform-state-lock-dynamo-${var.env}"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}
/*
resource "aws_s3_bucket_policy" "g-works-terraform-state-bucket-policy" {
  bucket = "g-works-terraform-state-${var.env}"
  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "NotPrincipal": {
        "AWS": [
          ${trim(jsonencode(data.aws_iam_group.Admin.users.*.arn), "[]")}
        ]
      },
      "Action": "s3:*",
      "Resource": [
        "${aws_s3_bucket.g-works-terraform-state.arn}/*",
        "${aws_s3_bucket.g-works-terraform-state.arn}"
      ],
      "Effect": "Deny"
    }
  ]
}
POLICY
}
*/
