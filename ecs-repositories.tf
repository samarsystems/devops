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


resource "aws_ecr_repository" "samar_ecr_repo_angular" {
  name = "${var.projectName}-ecr-angular-${var.env}"

  image_scanning_configuration {
    scan_on_push = true
  }
  tags = {
    Name        = "${var.projectName}-ecr-angular-${var.env}"
    Environment = var.env
  }
}