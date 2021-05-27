resource "aws_ecs_task_definition" "angular_task_def_app1" {
  family                   = "${var.projectName}-angular-task-def-app1-${var.env}"
  requires_compatibilities = ["FARGATE"]
  execution_role_arn       = "arn:aws:iam::527657010034:role/samar-ecs-task-execution-role-prod"
  task_role_arn            = "arn:aws:iam::527657010034:role/samar-ecs-task-execution-role-prod"
  network_mode             = var.network_mode
  cpu                      = "1024"
  memory                   = "2048"

  container_definitions = <<DEFINITION
    [
      {
        "name": "${var.projectName}-angular-container-app1-${var.env}",
        "image": "${var.samar_angular_image_app1}",
        "essential": true,
        "portMappings": [
          {
            "containerPort": 80,
            "hostPort": 80
          }
        ],
        "logConfiguration": {
          "logDriver": "awslogs",
          "options": {
            "awslogs-group": "${var.projectName}-angular-awslog-group-app1-${var.env}",
            "awslogs-region": "${var.region}",
            "awslogs-stream-prefix": "ecs"
          }
        }
      }
    ]
    DEFINITION

}

resource "aws_cloudwatch_log_group" "angular_awslogs_group_app1" {
  name = "${var.projectName}-angular-awslog-group-app1-${var.env}"

  tags = {
    Name        = "${var.projectName}-angular-awslog-group-app1-${var.env}"
    Environment = var.env
  }
}

