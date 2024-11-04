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
