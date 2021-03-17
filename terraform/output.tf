output "subnets" {
  value = module.network.public_subnets_ids
}

output "sg" {
  value = module.network.dependent_security_group_ids
}
