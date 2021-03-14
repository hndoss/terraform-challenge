module "two_tier_ec2" {
  source = "./modules/two-tier-ec2"

  project     = var.project
  environment = var.environment

  public_autoscaling_groups = [
    {
      name             = "public",
      image_id         = "this",
      instance_type    = "t3.micro",
      ssh_key_name     = "terraform",
      min_size         = 1,
      max_size         = 2,
      desired_capacity = 1,
      default_cooldown = 60,
      vpc_zone_identifier = [
        module.dev_network.private_subnets_ids["public-network-1"],
        module.dev_network.private_subnets_ids["public-network-2"],
      ],
      security_groups = [
        module.dev_network.security_group_ids["bastion"]
      ]
    }
  ]

  private_autoscaling_groups = [
    {
      name             = "private",
      image_id         = "this",
      instance_type    = "t3.micro",
      ssh_key_name     = "terraform",
      min_size         = 1,
      max_size         = 2,
      desired_capacity = 1,
      default_cooldown = 60,
      vpc_zone_identifier = [
        module.dev_network.private_subnets_ids["private-network-1"],
        module.dev_network.private_subnets_ids["private-network-2"],
      ],
      security_groups = [
        module.dev_network.security_group_ids["private"]
      ]
    }
  ]
}
