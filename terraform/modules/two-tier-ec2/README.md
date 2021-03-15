## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Modules

No Modules.

## Resources

| Name |
|------|
| [aws_ami](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami) |
| [aws_autoscaling_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/autoscaling_group) |
| [aws_launch_configuration](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/launch_configuration) |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| environment | Name of the environment. | `string` | n/a | yes |
| private\_autoscaling\_groups | Private autoscaling configuration. | <pre>set(object({<br>    name                = string<br>    image_id            = string<br>    instance_type       = string<br>    ssh_key_name        = string<br>    min_size            = number<br>    max_size            = number<br>    desired_capacity    = number<br>    default_cooldown    = string<br>    vpc_zone_identifier = list(string)<br>    security_groups     = list(string)<br>  }))</pre> | n/a | yes |
| project | Name of the project. | `string` | n/a | yes |
| public\_autoscaling\_groups | Public autoscaling configuration. | <pre>set(object({<br>    name                = string<br>    image_id            = string<br>    instance_type       = string<br>    ssh_key_name        = string<br>    min_size            = number<br>    max_size            = number<br>    desired_capacity    = number<br>    default_cooldown    = string<br>    vpc_zone_identifier = list(string)<br>    security_groups     = list(string)<br>  }))</pre> | n/a | yes |
| target\_group\_arns | List of the Target group ARNS to register the private autoscaling group | `list(string)` | n/a | yes |

## Outputs

No output.
