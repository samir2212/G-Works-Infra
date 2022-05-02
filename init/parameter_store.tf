variable "mysql_password" {
  type = string
}

resource "aws_ssm_parameter" "secret" {
  name        = "/prod/mysql_rds_master_password"
  description = "mysql DB password"
  type        = "SecureString"
  value       = var.mysql_password
}
