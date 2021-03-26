# java load balancer security group
resource "aws_security_group" "java_lb_sg" {
  name        = "${var.projectName}-java-lb-sg-${var.env}"
  description = "Allow http & https inbound traffic"
  vpc_id      = aws_vpc.samar_vpc.id

  ingress {
    description      = "https port"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    description      = "http port"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
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
    description      = "https port"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    description      = "http port"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
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
# java ECS security group
resource "aws_security_group" "java_ecs_sg" {
  name        = "${var.projectName}-java-ecs-sg-${var.env}"
  description = "Allow java port for load balancer"
  vpc_id      = aws_vpc.samar_vpc.id

  ingress {
    description     = "Allow java port for load balancer"
    from_port       = 8080
    to_port         = 8080
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

# java EFS security group
resource "aws_security_group" "java_efs_sg" {
  name        = "${var.projectName}-java-efs-sg-${var.env}"
  description = "Allow angular ECS service to connect EFS"
  vpc_id      = aws_vpc.samar_vpc.id

  ingress {
    description     = "Allow java ECS service to connect EFS"
    from_port       = 2049
    to_port         = 2049
    protocol        = "tcp"
    security_groups = [aws_security_group.java_ecs_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "${var.projectName}-java-efs-sg-${var.env}"
    Environment = var.env
  }
}

# angular EFS security group
resource "aws_security_group" "angular_efs_sg" {
  name        = "${var.projectName}-angular-efs-sg-${var.env}"
  description = "Allow angular ECS service to connect EFS"
  vpc_id      = aws_vpc.samar_vpc.id

  ingress {
    description     = "Allow angular ECS service to connect EFS"
    from_port       = 2049
    to_port         = 2049
    protocol        = "tcp"
    cidr_blocks     = ["0.0.0.0/0"]
    security_groups = [aws_security_group.angular_ecs_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "${var.projectName}-angular-efs-sg-${var.env}"
    Environment = var.env
  }
}