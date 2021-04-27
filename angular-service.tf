resource "aws_ecs_service" "ecs_angular_service" {
  name            = "${var.projectName}-ecs-angular-service-${var.env}"
  cluster         = aws_ecs_cluster.samar_ecs_cluster.id
  task_definition = aws_ecs_task_definition.angular_task_def.arn
  desired_count   = 2
  launch_type     = "FARGATE"

  network_configuration {
    security_groups  = [aws_security_group.angular_ecs_sg.id]
    subnets          = [aws_subnet.samar_pri_sub_1.id, aws_subnet.samar_pri_sub_2.id]
    assign_public_ip = false
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.samar_angular_tg.id
    container_name   = "${var.projectName}-angular-container-${var.env}"
    container_port   = 80
  }


}