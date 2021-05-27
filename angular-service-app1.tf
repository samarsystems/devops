resource "aws_ecs_service" "ecs_angular_service_app1" {
  name            = "${var.projectName}-ecs-angular-service-app1-${var.env}"
  cluster         = aws_ecs_cluster.samar_ecs_cluster.id
  task_definition = aws_ecs_task_definition.angular_task_def_app1.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    security_groups  = [aws_security_group.angular_ecs_sg_app1.id]
    subnets          = [aws_subnet.samar_pri_sub_1.id, aws_subnet.samar_pri_sub_2.id]
    assign_public_ip = false
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.samar_angular_tg_app1.id
    container_name   = "${var.projectName}-angular-container-app1-${var.env}"
    container_port   = 80
  }
}