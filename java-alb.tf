resource "aws_lb_target_group" "samar_java_tg" {
  name        = "${var.projectName}-java-tg-${var.env}"
  target_type = "ip"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = aws_vpc.samar_vpc.id

  health_check {
    healthy_threshold   = "5"
    unhealthy_threshold = "2"
    interval            = "30"
    matcher             = "200"
    path                = "/"
    port                = "traffic-port"
    protocol            = "HTTP"
    timeout             = "5"
  }

  tags = {
    Name        = "${var.projectName}-java-tg-${var.env}"
    Environment = var.env
  }
}

resource "aws_lb_listener" "java_port_80_listner" {
  load_balancer_arn = aws_lb.samar_java_alb.arn
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

resource "aws_lb_listener" "java_port_443_listner" {
  load_balancer_arn = aws_lb.samar_java_alb.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-TLS-1-2-Ext-2018-06"
  certificate_arn   = "arn:aws:acm:us-east-1:527657010034:certificate/b3a74cf7-0c11-4cf3-95c5-2e0fab62418b"

  default_action {
    target_group_arn = aws_lb_target_group.samar_java_tg.arn
    type             = "forward"
  }
}


resource "aws_lb" "samar_java_alb" {
  name               = "${var.projectName}-java-alb-${var.env}"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.java_lb_sg.id]
  subnets            = [aws_subnet.samar_pub_sub_1.id, aws_subnet.samar_pub_sub_2.id]

  tags = {
    Name        = "${var.projectName}-java-tg-${var.env}"
    Environment = var.env
  }
}
