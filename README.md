# terraform-G-works

# HowTo

## Prerequisites

1. export below environment variables in your shell:
   - AWS_ACCESS_KEY_ID=<YOUR_IAM_AWS_ACCESS_KEY_ID>
   - AWS_SECRET_ACCESS_KEY=<YOUR_IAM_AWS_SECRET_ACCESS_KEY>

## Terraform init

```
terraform init
```

In the current situation the terraform state already exist in s3 bucket.

## Deploy Bitadx Infrastructure

```
terraform plan
terraform apply
```

## Requirements

| Name                                                   | Version |
| ------------------------------------------------------ | ------- |
| <a name="requirement_aws"></a> [aws](#requirement_aws) | ~> 3.0  |

## Providers

| Name                                             | Version |
| ------------------------------------------------ | ------- |
| <a name="provider_aws"></a> [aws](#provider_aws) | 3.75.1  |

## Modules

| Name                                                                                | Source                                   | Version |
| ----------------------------------------------------------------------------------- | ---------------------------------------- | ------- |
| <a name="module_alb"></a> [alb](#module_alb)                                        | terraform-aws-modules/alb/aws            | 6.4.0   |
| <a name="module_ecs"></a> [ecs](#module_ecs)                                        | terraform-aws-modules/ecs/aws            | 3.4.1   |
| <a name="module_mysql-master-rds"></a> [mysql-master-rds](#module_mysql-master-rds) | terraform-aws-modules/rds/aws            | 3.5.0   |
| <a name="module_sg_alb"></a> [sg_alb](#module_sg_alb)                               | terraform-aws-modules/security-group/aws | 4.7.0   |
| <a name="module_vpc"></a> [vpc](#module_vpc)                                        | terraform-aws-modules/vpc/aws            | 2.77.0  |

## Resources

| Name                                                                                                                                                                                        | Type        |
| ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------- |
| [aws_acm_certificate.cert](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/acm_certificate)                                                                     | resource    |
| [aws_appautoscaling_policy.ecs_policy_cpu](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/appautoscaling_policy)                                               | resource    |
| [aws_appautoscaling_policy.ecs_policy_memory](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/appautoscaling_policy)                                            | resource    |
| [aws_appautoscaling_target.ecs_target](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/appautoscaling_target)                                                   | resource    |
| [aws_cloudwatch_log_group.php_log_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group)                                                  | resource    |
| [aws_ecr_repository.php_app](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecr_repository)                                                                    | resource    |
| [aws_ecs_service.ecs_service](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_service)                                                                      | resource    |
| [aws_ecs_task_definition.php_app_task_definition](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_task_definition)                                          | resource    |
| [aws_iam_policy.pull_env_from_s3_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy)                                                            | resource    |
| [aws_iam_role.task_execution_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role)                                                                    | resource    |
| [aws_iam_role.task_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role)                                                                              | resource    |
| [aws_iam_role_policy_attachment.ecs-task-execution-role-policy-attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment)          | resource    |
| [aws_iam_role_policy_attachment.ecs_role_s3_data_bucket_policy_attach](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment)              | resource    |
| [aws_s3_bucket.env-bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket)                                                                           | resource    |
| [aws_s3_bucket_acl.env-bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_acl)                                                                   | resource    |
| [aws_s3_bucket_public_access_block.env-bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_public_access_block)                                   | resource    |
| [aws_s3_bucket_server_side_encryption_configuration.env-bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_server_side_encryption_configuration) | resource    |
| [aws_s3_bucket_versioning.env-bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_versioning)                                                     | resource    |
| [aws_security_group.mysql-rds-sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group)                                                               | resource    |
| [aws_iam_policy_document.s3_data_bucket_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document)                                         | data source |
| [aws_ssm_parameter.mysql_rds_master_password](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ssm_parameter)                                                 | data source |

## Inputs

| Name                                                                                    | Description      | Type        | Default                                                                       | Required |
| --------------------------------------------------------------------------------------- | ---------------- | ----------- | ----------------------------------------------------------------------------- | :------: |
| <a name="input_aws_region"></a> [aws_region](#input_aws_region)                         | n/a              | `string`    | `"eu-north-1"`                                                                |    no    |
| <a name="input_az_list"></a> [az_list](#input_az_list)                                  | n/a              | `list(any)` | <pre>[<br> "eu-north-1a",<br> "eu-north-1b"<br>]</pre>                        |    no    |
| <a name="input_ecs_php_app"></a> [ecs_php_app](#input_ecs_php_app)                      | n/a              | `string`    | `"php_app"`                                                                   |    no    |
| <a name="input_env"></a> [env](#input_env)                                              | Environment name | `string`    | `"prod"`                                                                      |    no    |
| <a name="input_env_file"></a> [env_file](#input_env_file)                               | n/a              | `string`    | `"prod.env"`                                                                  |    no    |
| <a name="input_php_app_image"></a> [php_app_image](#input_php_app_image)                | n/a              | `string`    | `"141204083709.dkr.ecr.eu-central-1.amazonaws.com/php_app-prod:ecs-dev-test"` |    no    |
| <a name="input_project"></a> [project](#input_project)                                  | n/a              | `string`    | `"g-works"`                                                                   |    no    |
| <a name="input_username"></a> [username](#input_username)                               | n/a              | `string`    | `"admin"`                                                                     |    no    |
| <a name="input_vpc_cidr"></a> [vpc_cidr](#input_vpc_cidr)                               | n/a              | `string`    | `"10.200.0.0/16"`                                                             |    no    |
| <a name="input_vpc_cidr_private_a"></a> [vpc_cidr_private_a](#input_vpc_cidr_private_a) | n/a              | `string`    | `"10.200.11.0/24"`                                                            |    no    |
| <a name="input_vpc_cidr_private_b"></a> [vpc_cidr_private_b](#input_vpc_cidr_private_b) | n/a              | `string`    | `"10.200.12.0/24"`                                                            |    no    |
| <a name="input_vpc_cidr_public_a"></a> [vpc_cidr_public_a](#input_vpc_cidr_public_a)    | n/a              | `string`    | `"10.200.1.0/24"`                                                             |    no    |
| <a name="input_vpc_cidr_public_b"></a> [vpc_cidr_public_b](#input_vpc_cidr_public_b)    | n/a              | `string`    | `"10.200.2.0/24"`                                                             |    no    |

## Outputs

No outputs.
