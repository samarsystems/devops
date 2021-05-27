resource "aws_ecs_task_definition" "angular_task_def_admin" {
  family                   = "${var.projectName}-angular-task-def_admin-${var.env}"
  requires_compatibilities = ["FARGATE"]
  execution_role_arn       = "arn:aws:iam::527657010034:role/samar-ecs-task-execution-role-prod"
  task_role_arn            = "arn:aws:iam::527657010034:role/samar-ecs-task-execution-role-prod"
  network_mode             = var.network_mode
  cpu                      = "1024"
  memory                   = "2048"

  container_definitions = <<DEFINITION
    [
      {
        "name": "${var.projectName}-angular-container-admin-${var.env}",
        "image": "${var.samar_angular_image_admin}",
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
            "awslogs-group": "${var.projectName}-angular-awslog-group-admin-${var.env}",
            "awslogs-region": "${var.region}",
            "awslogs-stream-prefix": "ecs"
          }
        }
      }
    ]
    DEFINITION

}

resource "aws_cloudwatch_log_group" "angular_awslogs_group" {
  name = "${var.projectName}-angular-awslog-group-admin-${var.env}"

  tags = {
    Name        = "${var.projectName}-angular-awslog-group1-${var.env}"
    Environment = var.env
  }
}

