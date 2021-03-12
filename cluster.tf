resource "aws_ecs_cluster" "samar_ecs_cluster" {
  name = "${var.projectName}-ecs-${var.env}"

  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}