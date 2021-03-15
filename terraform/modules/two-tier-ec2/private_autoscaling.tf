resource "aws_launch_template" "private_launch_configuration" {
  for_each = { for launch_configuration in var.private_autoscaling_groups : launch_configuration.name => launch_configuration }

  name          = each.value.name
  description   = "Launche configuration for ${local.name_prefix}"
  image_id      = each.value.image_id
  instance_type = each.value.instance_type
  key_name      = each.value.ssh_key_name

  network_interfaces {
    associate_public_ip_address = false
    delete_on_termination       = true
    security_groups             = each.value.security_groups
  }
}


resource "aws_autoscaling_group" "private_autoscaling_group" {
  for_each = { for launch_template in var.private_autoscaling_groups : launch_template.name => launch_template }

  name                  = each.value.name
  min_size              = each.value.min_size
  max_size              = each.value.max_size
  desired_capacity      = each.value.desired_capacity
  vpc_zone_identifier   = each.value.vpc_zone_identifier
  default_cooldown      = each.value.default_cooldown
  termination_policies  = ["OldestInstance"]
  protect_from_scale_in = false
  target_group_arns     = var.target_group_arns

  launch_template {
    id      = aws_launch_template.private_launch_configuration[each.value.name].id
    version = aws_launch_template.private_launch_configuration[each.value.name].latest_version
  }

  tag {
    key                 = "Name"
    value               = "${local.name_prefix}-${each.value.name}"
    propagate_at_launch = true
  }

  tag {
    key                 = "Project"
    value               = var.project
    propagate_at_launch = true
  }

  depends_on = [aws_launch_template.private_launch_configuration]
}
