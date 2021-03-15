module "two_tier_ec2" {
  source = "./modules/two-tier-ec2"

  project     = var.project
  environment = var.environment

  target_group_arns = [
    aws_lb_target_group.target_group_80.arn
  ]

  public_autoscaling_groups = [
    {
      name             = "public",
      image_id         = "ami-0ca5c3bd5a268e7db"
      instance_type    = "t3.micro",
      ssh_key_name     = "terraform",
      min_size         = 1,
      max_size         = 2,
      desired_capacity = 1,
      default_cooldown = 60,
      vpc_zone_identifier = [
        module.network.public_subnets_ids["public-network-1"],
        module.network.public_subnets_ids["public-network-2"],
        module.network.public_subnets_ids["public-network-3"],
      ],
      security_groups = [
        module.network.independent_security_group_ids["bastion"]
      ]
    }
  ]

  private_autoscaling_groups = [
    {
      name             = "private",
      image_id         = data.aws_ami.ami.image_id
      instance_type    = "t3.micro",
      ssh_key_name     = "terraform",
      min_size         = 1,
      max_size         = 2,
      desired_capacity = 1,
      default_cooldown = 60,
      vpc_zone_identifier = [
        module.network.private_subnets_ids["private-network-1"],
        module.network.private_subnets_ids["private-network-2"],
        module.network.private_subnets_ids["private-network-3"],
      ],
      security_groups = [
        module.network.dependent_security_group_ids["private"]
      ]
    }
  ]
}
