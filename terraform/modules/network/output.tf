output "vpc_id" {
  description = "Main vpc id"
  value       = aws_vpc.main.id
}

output "public_subnets_ids" {
  description = "Available public subnet ids"
  value = {
    for subnet in aws_subnet.public_subnets : subnet.tags["Name"] => subnet.id
  }
}

output "private_subnets_ids" {
  description = "Available private subnet ids"
  value = {
    for subnet in aws_subnet.private_subnets : subnet.tags["Name"] => subnet.id
  }
}

output "independent_security_group_ids" {
  description = "Security groups ids"
  value = {
    for security_group in aws_security_group.independent_security_groups : security_group.name => security_group.id
  }
}

output "dependent_security_group_ids" {
  description = "Security groups ids"
  value = {
    for security_group in aws_security_group.dependent_security_groups : security_group.name => security_group.id
  }
}

# output "security_group_ids" {
#   description = "All the ids of the generated security groups"
#   value = local.security_groups_ids
# }
