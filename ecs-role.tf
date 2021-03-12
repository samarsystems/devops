# ECS task execution role data
data "aws_iam_policy_document" "samar_ecs_task_execution_role" {
  version = "2012-10-17"
  statement {
    sid     = ""
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}


# ECS task execution role
resource "aws_iam_role" "samar_ecs_task_execution_role" {
  name               = "${var.projectName}-ecs-task-execution-role-${var.env}"
  assume_role_policy = data.aws_iam_policy_document.samar_ecs_task_execution_role.json
}

# ECS task execution role policy attachment
resource "aws_iam_role_policy_attachment" "samar_ecs_task_execution_role_attachment" {
  role       = aws_iam_role.samar_ecs_task_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}