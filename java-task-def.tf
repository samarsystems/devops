resource "aws_ecs_task_definition" "java_task_def" {
  family                   = "${var.projectName}-java-task-def-${var.env}"
  requires_compatibilities = ["FARGATE"]
  execution_role_arn       = "arn:aws:iam::527657010034:role/samar-ecs-task-execution-role-prod"
  task_role_arn            = "arn:aws:iam::527657010034:role/samar-ecs-task-execution-role-prod"
  network_mode             = var.network_mode
  cpu                      = "2048"
  memory                   = "4096"

  container_definitions = <<DEFINITION
    [
      {
        "name": "java",
        "image": "${var.samar_java_image}",
        "essential": true,
        "portMappings": [
          {
            "containerPort": 8080,
            "hostPort": 8080
          }
        ],
      "essential": true,
      "mountPoints": [
          {
              "containerPath": "/ssAppArea",
              "sourceVolume": "Java-efs-AppArea"
          }
      ],

        "logConfiguration": {
          "logDriver": "awslogs",
          "options": {
            "awslogs-group": "${var.projectName}-java-awslog-group-${var.env}",
            "awslogs-region": "${var.region}",
            "awslogs-stream-prefix": "ecs"
          }
        }
      }
    ]
    DEFINITION

  volume {
    name = "Java-efs-AppArea"
    efs_volume_configuration {
      file_system_id = aws_efs_file_system.java_efs.id
      root_directory = "/"
    }
  }
}


resource "aws_cloudwatch_log_group" "java_awslogs_group" {
  name = "${var.projectName}-java-awslog-group-${var.env}"

  tags = {
    Name        = "${var.projectName}-java-awslog-group-${var.env}"
    Environment = var.env
  }
}


