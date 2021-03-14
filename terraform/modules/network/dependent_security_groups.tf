resource "aws_security_group" "dependent_security_groups" {
  for_each = { for security_group in var.dependent_security_group_config : security_group.name => security_group }

  name        = each.value.name
  description = each.value.description
  vpc_id      = aws_vpc.main.id

  dynamic "ingress" {
    for_each = { for rule in each.value.ingress : rule.from_port => rule }

    content {
      from_port       = ingress.value.from_port
      to_port         = ingress.value.to_port
      protocol        = ingress.value.protocol
      cidr_blocks     = ingress.value.cidr_blocks
      security_groups = ingress.value.security_groups
    }
  }

  dynamic "egress" {
    for_each = { for rule in each.value.egress : rule.from_port => rule }

    content {
      from_port       = egress.value.from_port
      to_port         = egress.value.to_port
      protocol        = egress.value.protocol
      cidr_blocks     = egress.value.cidr_blocks
      security_groups = egress.value.security_groups
    }
  }

  tags = {
    Name    = each.value.name
    Project = var.project
  }
}
