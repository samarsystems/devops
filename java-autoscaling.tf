resource "aws_appautoscaling_target" "nginx_auto_scaling_nginx" {
  service_namespace  = "ecs"
  resource_id        = "service/${aws_ecs_cluster.samar_ecs_cluster.name}/${aws_ecs_service.ecs_nginx_service.name}"
  scalable_dimension = "ecs:service:DesiredCount"
  min_capacity       = 1
  max_capacity       = 100
}

resource "aws_appautoscaling_policy" "samar_autoscalingpolicy_cpu" {
  name               = "${var.projectName}-autoscalingpolicy-cpu-${var.env}"
  policy_type        = "TargetTrackingScaling"
  resource_id        = aws_appautoscaling_target.nginx_auto_scaling_nginx.resource_id
  scalable_dimension = aws_appautoscaling_target.nginx_auto_scaling_nginx.scalable_dimension
  service_namespace  = aws_appautoscaling_target.nginx_auto_scaling_nginx.service_namespace

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

resource "aws_appautoscaling_policy" "samar_autoscalingpolicy_mem" {
  name               = "${var.projectName}-autoscalingpolicy-mem-${var.env}"
  policy_type        = "TargetTrackingScaling"
  resource_id        = aws_appautoscaling_target.nginx_auto_scaling_nginx.resource_id
  scalable_dimension = aws_appautoscaling_target.nginx_auto_scaling_nginx.scalable_dimension
  service_namespace  = aws_appautoscaling_target.nginx_auto_scaling_nginx.service_namespace

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