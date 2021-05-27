resource "aws_appautoscaling_target" "ecs_angular_auto_scaling_admin" {
  service_namespace  = "ecs"
  resource_id        = "service/${aws_ecs_cluster.samar_ecs_cluster.name}/${aws_ecs_service.ecs_angular_service_admin.name}"
  scalable_dimension = "ecs:service:DesiredCount"
  min_capacity       = 1
  max_capacity       = 100
}

resource "aws_appautoscaling_policy" "samar_angular_autoscalingpolicy_cpu_admin" {
  name               = "${var.projectName}-angular-autoscalingpolicy-cpu_admin-${var.env}"
  policy_type        = "TargetTrackingScaling"
  resource_id        = aws_appautoscaling_target.ecs_angular_auto_scaling_admin.resource_id
  scalable_dimension = aws_appautoscaling_target.ecs_angular_auto_scaling_admin.scalable_dimension
  service_namespace  = aws_appautoscaling_target.ecs_angular_auto_scaling_admin.service_namespace

  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ECSServiceAverageCPUUtilization"
    }

    target_value       = 75
    disable_scale_in   = false
    scale_in_cooldown  = 300
    scale_out_cooldown = 300
  }
}

resource "aws_appautoscaling_policy" "samar_angular_autoscalingpolicy_mem_admin" {
  name               = "${var.projectName}-angular-autoscalingpolicy-mem_admin-${var.env}"
  policy_type        = "TargetTrackingScaling"
  resource_id        = aws_appautoscaling_target.ecs_angular_auto_scaling_admin.resource_id
  scalable_dimension = aws_appautoscaling_target.ecs_angular_auto_scaling_admin.scalable_dimension
  service_namespace  = aws_appautoscaling_target.ecs_angular_auto_scaling_admin.service_namespace

  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ECSServiceAverageMemoryUtilization"
    }

    target_value       = 75
    disable_scale_in   = false
    scale_in_cooldown  = 300
    scale_out_cooldown = 300
  }
}