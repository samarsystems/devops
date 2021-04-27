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
