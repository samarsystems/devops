# java load balancer security group
resource "aws_security_group" "java_lb_sg" {
  name        = "${var.projectName}-java-lb-sg-${var.env}"
  description = "Allow http & https inbound traffic"
  vpc_id      = aws_vpc.samar_vpc.id

  ingress {
    description = "https port"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "http port"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "${var.projectName}-java-lb-sg-${var.env}"
    Environment = var.env
  }
}
# Angular load balancer security group
resource "aws_security_group" "angular_lb_sg" {
  name        = "${var.projectName}-angular-lb-sg-${var.env}"
  description = "Allow http & https inbound traffic"
  vpc_id      = aws_vpc.samar_vpc.id

  ingress {
    description = "https port"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "http port"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "${var.projectName}-anjular-lb-sg-${var.env}"
    Environment = var.env
  }
}
# Angular ECS security group
resource "aws_security_group" "angular_ecs_sg" {
  name        = "${var.projectName}-angular-ecs-sg-${var.env}"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.samar_vpc.id

  ingress {
    description     = "Allow Angular port for load balancer"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.angular_lb_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "${var.projectName}-anjular-ecs-sg-${var.env}"
    Environment = var.env
  }
}
# Java ECS security group
resource "aws_security_group" "java_ecs_sg" {
  name        = "${var.projectName}-java-ecs-sg-${var.env}"
  description = "Allow Java port for load balancer"
  vpc_id      = aws_vpc.samar_vpc.id

  ingress {
    description     = "Allow Java port for load balancer"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.java_lb_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "${var.projectName}-java-ecs-sg-${var.env}"
    Environment = var.env
  }
}