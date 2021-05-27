resource "aws_instance" "samar_java_ec2_efs" {
  ami                         = "ami-013f17f36f8b1fefb"
  instance_type               = var.efs_ec2_instance_type
  key_name                    = "efs-mount-vm-java"
  subnet_id                   = aws_subnet.samar_pub_sub_1.id
  vpc_security_group_ids      = [aws_security_group.java_efs_ssh_sg.id]
  associate_public_ip_address = true

  tags = {
    Name        = "${var.projectName}-efs-vm-${var.env}"
    Environment = var.env
  }
}
