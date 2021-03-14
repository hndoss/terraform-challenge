resource "aws_lb" "loadbalancer" {
  name               = "${var.project}-${var.environment}"
  load_balancer_type = "application"

  subnets = [
    module.network.public_subnets_ids["public-network-1"],
    module.network.public_subnets_ids["public-network-2"],
    module.network.public_subnets_ids["public-network-3"],
  ]

  security_groups = [
    module.network.independent_security_group_ids["loadbalancer"]
  ]

  internal = false

  tags = {
    Name    = "${var.project}-${var.environment}"
    Project = var.project
  }
}

resource "aws_lb_target_group" "target_group_3000" {
  name     = "${var.project}-${var.environment}-3000"
  vpc_id   = module.network.vpc_id
  protocol = "HTTP"
  port     = 3000

  health_check {
    protocol            = "HTTP"
    path                = "/"
    port                = 3000
    healthy_threshold   = 3
    unhealthy_threshold = 10
    timeout             = 5
    interval            = 10
    matcher             = "200"
  }

  tags = {
    Name    = "${var.project}-${var.environment}"
    Project = var.project
  }
}

resource "aws_lb_listener" "listener_80" {
  load_balancer_arn = aws_lb.loadbalancer.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target_group_3000.arn
  }
}
