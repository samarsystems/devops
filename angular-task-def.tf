resource "aws_ecs_task_definition" "angular_task_def" {
  family                   = "${var.projectName}-angular-task-def-${var.env}"
  requires_compatibilities = ["FARGATE"]
  execution_role_arn       = "arn:aws:iam::527657010034:role/samar-ecs-task-execution-role-prod"
  task_role_arn            = "arn:aws:iam::527657010034:role/samar-ecs-task-execution-role-prod"
  network_mode             = var.network_mode
  cpu                      = "1024"
  memory                   = "2048"

  container_definitions = <<DEFINITION
[
  {
      "portMappings": [
          {
              "hostPort": 80,
              "containerPort": 80,
              "protocol": "tcp"
          }
      ],
      "essential": true,
      "mountPoints": [
          {
              "containerPath": "/usr/share/nginx/html",
              "sourceVolume": "efs-html"
          }
      ],
      "name": "angular",
      "image": "nginx"
  }
]
DEFINITION

  volume {
    name = "efs-html"
    efs_volume_configuration {
      file_system_id = aws_efs_file_system.angular_efs.id
      root_directory = "/"
    }
  }
}