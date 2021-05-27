resource "aws_lb_target_group" "samar_angular_tg_app1" {
  name        = "${var.projectName}-angular-tg-app1-${var.env}"
  target_type = "ip"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = aws_vpc.samar_vpc.id

  health_check {
    healthy_threshold   = "5"
    unhealthy_threshold = "2"
    interval            = "30"
    matcher             = "200-302"
    path                = "/"
    port                = "traffic-port"
    protocol            = "HTTP"
    timeout             = "5"
  }

  tags = {
    Name        = "${var.projectName}-angular-tg-app1-${var.env}"
    Environment = var.env
  }
}

resource "aws_lb" "samar_angular_alb_app1" {
  name               = "${var.projectName}-angular-alb-app1-${var.env}"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.angular_lb_sg_app1.id]
  subnets            = [aws_subnet.samar_pub_sub_1.id, aws_subnet.samar_pub_sub_2.id]

  tags = {
    Name        = "${var.projectName}-angular-tg-app1-${var.env}"
    Environment = var.env
  }
}

resource "aws_lb_listener" "angular_port_80_listner_app1" {
  load_balancer_arn = aws_lb.samar_angular_alb_app1.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

resource "aws_lb_listener" "angular_port_443_listner_app1" {
  load_balancer_arn = aws_lb.samar_angular_alb_app1.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-TLS-1-2-Ext-2018-06"
  certificate_arn   = "arn:aws:acm:us-east-1:527657010034:certificate/b3a74cf7-0c11-4cf3-95c5-2e0fab62418b"

  default_action {
    target_group_arn = aws_lb_target_group.samar_angular_tg_app1.arn
    type             = "forward"
  }
}
