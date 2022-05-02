data "aws_ssm_parameter" "mysql_rds_master_password" {
  name = "/prod/mysql_rds_master_password"
}
