module "vpc" {
  source               = "terraform-aws-modules/vpc/aws"
  version              = "2.77.0"
  name                 = var.project
  azs                  = var.az_list
  cidr                 = var.vpc_cidr
  public_subnets       = [var.vpc_cidr_public_a, var.vpc_cidr_public_b]
  private_subnets      = [var.vpc_cidr_private_a, var.vpc_cidr_private_b]
  enable_dhcp_options  = true
  enable_dns_hostnames = true
  enable_dns_support   = true
  enable_nat_gateway   = true
  single_nat_gateway   = false
}
