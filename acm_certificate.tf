resource "aws_acm_certificate" "cert" {
  domain_name       = "g.works"
  validation_method = "DNS"

  tags = {
    Name        = "g.works"
    Environment = "${var.env}"
  }

  subject_alternative_names = [
    "www.g.works",
  ]

  options {
    certificate_transparency_logging_preference = "ENABLED"
  }

  lifecycle {
    create_before_destroy = true
  }
}
