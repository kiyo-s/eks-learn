resource "aws_lb" "system" {
  name               = "${local.name}-system"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.system_lb.id]
  subnets            = [for subnet in aws_subnet.public : subnet.id]

  enable_deletion_protection = false

  tags = {
    Name = "${local.name}-system"
  }
}

resource "aws_security_group" "system_lb" {
  name   = "${local.name}-system-lb"
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${local.name}-system-lb"
  }
}

resource "aws_security_group_rule" "system_lb_ingress" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  security_group_id = aws_security_group.system_lb.id
  cidr_blocks       = var.eks_cluster_access_cidrs
}

resource "aws_security_group_rule" "system_lb_egress_all" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  security_group_id = aws_security_group.system_lb.id
  cidr_blocks       = ["0.0.0.0/0"]
}

data "aws_route53_zone" "main" {
  count = var.route_53_zone_name != null ? 1 : 0
  name  = var.route_53_zone_name
}

// OpenClarity
resource "aws_lb_target_group" "openclarity" {
  name     = "${local.name}-system"
  port     = 30003
  protocol = "HTTP"
  vpc_id   = aws_vpc.main.id

  tags = {
    Name = "${local.name}-system-lb-openclarity"
  }
}

resource "aws_autoscaling_attachment" "openclarity" {
  lb_target_group_arn    = aws_lb_target_group.openclarity.arn
  autoscaling_group_name = module.eks_node_group_system.autoscaling_group_name[0]
}

resource "aws_route53_record" "openclarity" {
  count   = var.route_53_zone_name != null ? 1 : 0
  zone_id = data.aws_route53_zone.main[0].zone_id
  name    = "openclarity.${var.route_53_zone_name}"
  type    = "A"

  alias {
    name                   = aws_lb.system.dns_name
    zone_id                = aws_lb.system.zone_id
    evaluate_target_health = true
  }
}

resource "aws_lb_listener" "openclarity" {
  load_balancer_arn = aws_lb.system.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.openclarity.arn
  }
}
