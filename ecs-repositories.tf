resource "aws_ecr_repository" "samar_ecr_repo_java" {
  name = "${var.projectName}-ecr-java-${var.env}"

  image_scanning_configuration {
    scan_on_push = true
  }
  tags = {
    Name        = "${var.projectName}-ecr-java-${var.env}"
    Environment = var.env
  }
}


resource "aws_ecr_repository" "samar_ecr_repo_angular_admin" {
  name = "${var.projectName}-ecr-angular-admin-${var.env}"

  image_scanning_configuration {
    scan_on_push = true
  }
  tags = {
    Name        = "${var.projectName}-ecr-angular1-${var.env}"
    Environment = var.env
  }
}

resource "aws_ecr_repository" "samar_ecr_repo_angular_app1" {
  name = "${var.projectName}-ecr-angular-app1-${var.env}"

  image_scanning_configuration {
    scan_on_push = true
  }
  tags = {
    Name        = "${var.projectName}-ecr-angular-app1-${var.env}"
    Environment = var.env
  }
}