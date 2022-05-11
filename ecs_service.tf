resource "aws_ecs_task_definition" "php_app_task_definition" {
  family                   = "${var.env}-${var.project}-${var.ecs_php_app}"
  task_role_arn            = aws_iam_role.task_role.arn
  execution_role_arn       = aws_iam_role.task_execution_role.arn
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "512"
  memory                   = "1024"


  container_definitions = jsonencode([
    {
      name      = "${var.ecs_php_app}"
      image     = "${var.php_app_image}"
      cpu       = 512
      memory    = 1024
      essential = true
      portMappings = [
        {
          containerPort = 80
          hostPort      = 80
        },
        {
          containerPort = 3000
          hostPort      = 3000
        }
      ]
      logConfiguration = {
        logDriver = "awslogs",
        options = {
          awslogs-group         = aws_cloudwatch_log_group.php_log_group.name,
          awslogs-region        = var.aws_region,
          awslogs-stream-prefix = "ecs"
        }
      }
      environmentFiles = [
        {
          value = "${aws_s3_bucket.env-bucket.arn}/${var.env_file}"
          "type" : "s3"
        }
      ]
    }
  ])
}

resource "aws_ecs_service" "ecs_service" {
  name                              = var.ecs_php_app
  cluster                           = module.ecs.ecs_cluster_id
  launch_type                       = "FARGATE"
  desired_count                     = 1
  task_definition                   = aws_ecs_task_definition.php_app_task_definition.arn
  health_check_grace_period_seconds = 360

  load_balancer {
    target_group_arn = module.alb.target_group_arns[0]
    container_name   = var.ecs_php_app
    container_port   = 80
  }

  load_balancer {
    target_group_arn = module.alb.target_group_arns[1]
    container_name   = var.ecs_php_app
    container_port   = 3000
  }

  network_configuration {
    security_groups = [module.sg_alb.security_group_id]
    subnets         = module.vpc.private_subnets
  }
  tags = {
    Name        = var.ecs_php_app,
    Environment = var.env
  }
  depends_on = [module.alb, module.ecs, module.vpc]
}

resource "aws_cloudwatch_log_group" "php_log_group" {
  name              = "/ecs/${var.project}/${var.ecs_php_app}"
  retention_in_days = 90

  tags = {
    Environment = var.env
  }
}
