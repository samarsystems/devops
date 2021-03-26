resource "aws_efs_file_system" "java_efs" {
  encrypted = true

  tags = {
    Name        = "${var.projectName}-java-efs-${var.env}"
    Environment = var.env
  }
}

resource "aws_efs_mount_target" "java_efs_target" {
  file_system_id  = aws_efs_file_system.java_efs.id
  subnet_id       = aws_subnet.samar_pri_sub_1.id
  security_groups = [aws_security_group.java_efs_sg.id]
}

resource "aws_efs_file_system" "angular_efs" {
  encrypted = true

  tags = {
    Name        = "${var.projectName}-angular-efs-${var.env}"
    Environment = var.env
  }
}

resource "aws_efs_mount_target" "angular_efs_target" {
  file_system_id  = aws_efs_file_system.angular_efs.id
  subnet_id       = aws_subnet.samar_pri_sub_2.id
  security_groups = [aws_security_group.angular_efs_sg.id]
}
