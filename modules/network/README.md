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
| [aws_eip](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip) |
| [aws_internet_gateway](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway) |
| [aws_nat_gateway](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/nat_gateway) |
| [aws_route_table](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) |
| [aws_route_table_association](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) |
| [aws_security_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) |
| [aws_subnet](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) |
| [aws_vpc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc) |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| cidr\_block | Main vpc cidr block | `string` | `"10.0.0.0/16"` | no |
| environment | Name of the environment | `string` | n/a | yes |
| natgateway\_subnet\_name | The Subnet name of the subnet in which the NAT gateway will be placed | `string` | n/a | yes |
| private\_subnets | Private subnets configuration. | <pre>set(object({<br>    name              = string<br>    availability_zone = string<br>    cidr_block        = string<br>  }))</pre> | <pre>[<br>  {<br>    "availability_zone": "eu-central-1a",<br>    "cidr_block": "10.0.0.1/24",<br>    "name": "my-subnet"<br>  }<br>]</pre> | no |
| project | Name of the project | `string` | n/a | yes |
| public\_subnets | Public subnets configuration. | <pre>set(object({<br>    name              = string<br>    availability_zone = string<br>    cidr_block        = string<br>  }))</pre> | <pre>[<br>  {<br>    "availability_zone": "eu-central-1a",<br>    "cidr_block": "10.0.0.0/24",<br>    "name": "my-subnet"<br>  }<br>]</pre> | no |
| security\_group\_config | Security groups configuration | <pre>set(object({<br>    name        = string<br>    description = string<br>    ingress = set(object({<br>      from_port       = number<br>      to_port         = number<br>      protocol        = string<br>      cidr_blocks     = list(string)<br>      security_groups = list(string)<br>    }))<br>    egress = set(object({<br>      from_port       = number<br>      to_port         = number<br>      protocol        = string<br>      cidr_blocks     = list(string)<br>      security_groups = list(string)<br>    }))<br>  }))</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| private\_subnets\_ids | Available private subnet ids |
| public\_subnets\_ids | Available public subnet ids |
| security\_group\_ids | Security groups ids |
| vpc\_id | Main vpc id. |
