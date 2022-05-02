module "sg_alb" {
  source      = "terraform-aws-modules/security-group/aws"
  version     = "4.7.0"
  name        = "${var.env}-${var.project}-alb"
  description = "ALB SG ${var.env}-${var.project}"
  vpc_id      = module.vpc.vpc_id

  ingress_with_cidr_blocks = [
    {
      rule        = "http-80-tcp"
      cidr_blocks = "0.0.0.0/0"
    },
    {
      rule        = "https-443-tcp"
      cidr_blocks = "0.0.0.0/0"
    },
  ]
  egress_rules = ["all-all"]
}

module "alb" {
  source                           = "terraform-aws-modules/alb/aws"
  version                          = "6.4.0"
  name                             = "${var.env}-${var.project}-alb"
  load_balancer_type               = "application"
  vpc_id                           = module.vpc.vpc_id
  subnets                          = module.vpc.public_subnets[*]
  security_groups                  = [module.sg_alb.security_group_id]
  enable_deletion_protection       = false
  enable_http2                     = true
  enable_cross_zone_load_balancing = true
  listener_ssl_policy_default      = "ELBSecurityPolicy-TLS-1-2-2017-01"
  /*
  # Waiting for customer to validate certificate
   https_listeners = [
     {
       port               = 443
       protocol           = "HTTPS"
       certificate_arn    = aws_acm_certificate.cert.arn
       target_group_index = 0
     },
  ]
  */

  target_groups = [
    {
      name_prefix      = "pref-"
      backend_protocol = "HTTP"
      backend_port     = 80
      target_type      = "ip"
      health_check = {
        enabled             = true
        healthy_threshold   = 5
        interval            = 30
        matcher             = "200"
        path                = "/"
        port                = "traffic-port"
        protocol            = "HTTP"
        timeout             = 5
        unhealthy_threshold = 2
      }
    }
  ]

  http_tcp_listeners = [
    {
      port     = 80
      protocol = "HTTP"
      #action_type = "redirect"
      #redirect = {
      #port        = "443"
      #protocol    = "HTTPS"
      #status_code = "HTTP_301"
      #}
    }
  ]
}
