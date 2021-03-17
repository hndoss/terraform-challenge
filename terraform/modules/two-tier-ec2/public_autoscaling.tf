resource "aws_launch_configuration" "public_launch_configuration" {
  for_each = { for launch_configuration in var.public_autoscaling_groups : launch_configuration.name => launch_configuration }

  name                        = each.value.name
  image_id                    = each.value.image_id
  instance_type               = each.value.instance_type
  security_groups             = each.value.security_groups
  key_name                    = each.value.ssh_key_name
  associate_public_ip_address = true

  user_data = templatefile("${path.module}/files/init.sh", {
    MESSAGE = "hello world"
  })
}

resource "aws_autoscaling_group" "public_autoscaling_group" {
  for_each = { for launch_configuration in var.public_autoscaling_groups : launch_configuration.name => launch_configuration }

  name                  = each.value.name
  min_size              = each.value.min_size
  max_size              = each.value.max_size
  desired_capacity      = each.value.desired_capacity
  launch_configuration  = each.value.name
  vpc_zone_identifier   = each.value.vpc_zone_identifier
  default_cooldown      = each.value.default_cooldown
  termination_policies  = ["OldestInstance"]
  protect_from_scale_in = false

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

  depends_on = [aws_launch_configuration.public_launch_configuration]
}
