# How To

# Terraform Description

## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| network | ../modules/network |  |
| routes | ../modules/routes |  |
| two_tier_ec2 | ./modules/two-tier-ec2 |  |

## Resources

| Name |
|------|
| [aws_lb](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb) |
| [aws_lb_listener](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener) |
| [aws_lb_target_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group) |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| aws\_access\_key\_id | Specifies the AWS access key used as part of the credentials to authenticate the user | `string` | n/a | yes |
| aws\_region | Specifies the AWS Region to send the request to | `string` | n/a | yes |
| aws\_secret\_access\_key | Specifies the AWS secret key used as part of the credentials to authenticate the user | `string` | n/a | yes |
| environment | Name of the environment | `string` | n/a | yes |
| project | Name of the project | `string` | n/a | yes |

## Outputs

No output.
