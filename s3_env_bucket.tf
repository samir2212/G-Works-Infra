resource "aws_s3_bucket" "env-bucket" {
  bucket = "${var.project}-${var.env}-env-bucket"
  tags = {
    Name        = "${var.project}-env-bucket"
    Environment = "${var.env}"
  }
}

resource "aws_s3_bucket_versioning" "env-bucket" {
  bucket = aws_s3_bucket.env-bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_acl" "env-bucket" {
  bucket = aws_s3_bucket.env-bucket.id
  acl    = "private"
}

resource "aws_s3_bucket_server_side_encryption_configuration" "env-bucket" {
  bucket = aws_s3_bucket.env-bucket.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "env-bucket" {
  bucket                  = aws_s3_bucket.env-bucket.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
