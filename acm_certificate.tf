resource "aws_acm_certificate" "cert" {
  domain_name       = "talovisio.fi"
  validation_method = "DNS"

  tags = {
    Name        = "talovisio.fi"
    Environment = "${var.env}"
  }

  subject_alternative_names = [
    "*.talovisio.fi",
  ]

  options {
    certificate_transparency_logging_preference = "ENABLED"
  }

  lifecycle {
    create_before_destroy = true
  }
}
