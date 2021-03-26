resource "aws_ecs_task_definition" "java_task_def" {
  family                   = "${var.projectName}-java-task-def-${var.env}"
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
              "hostPort": 8080,
              "containerPort": 8080,
              "protocol": "tcp"
          }
      ],
      "essential": true,
       "mountPoints": [],
      "name": "java",
      "image": "527657010034.dkr.ecr.us-east-1.amazonaws.com/samar-ecr-java-prod:latest"
  }
]
DEFINITION

}
