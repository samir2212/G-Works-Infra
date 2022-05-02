module "ecs" {
  source  = "terraform-aws-modules/ecs/aws"
  version = "3.4.1"
  name    = "${var.env}-${var.project}"
}
