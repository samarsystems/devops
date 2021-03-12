resource "aws_ecs_task_definition" "nginx_task_def1" {
  family                   = "${var.projectName}-nginx-task-def-${var.env}"
  requires_compatibilities = ["FARGATE"]
  execution_role_arn       = "arn:aws:iam::527657010034:role/samar-ecs-task-execution-role-prod"
  task_role_arn            = "arn:aws:iam::527657010034:role/samar-ecs-task-execution-role-prod"
  container_definitions    = file("task-definitions/nginx.json")
  network_mode             = var.network_mode
  cpu                      = "1024"
  memory                   = "2048"

}

  