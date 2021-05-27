## VPC variable  ##

variable "vpc_cidr_block" {
  default     = "10.10.0.0/16"
  type        = string
  description = "CIDR block for the VPC"
}

variable "pub_sub_cidr-1" {
  default     = "10.10.1.0/24"
  type        = string
  description = "CIDR block for the public subnet 1"
}

variable "pub_sub_cidr-2" {
  default     = "10.10.3.0/24"
  type        = string
  description = "CIDR block for the public subnet 2"
}

variable "pri_sub_cidr-1" {
  default     = "10.10.2.0/24"
  type        = string
  description = "CIDR block for the private subnet 1"
}

variable "pri_sub_cidr-2" {
  default     = "10.10.4.0/24"
  type        = string
  description = "CIDR block for the private subnet 2"
}

variable "availablity_zone-a" {
  default     = "us-east-1a"
  type        = string
  description = "Availablity Zone 1 for subnets"
}

variable "availablity_zone-b" {
  default     = "us-east-1b"
  type        = string
  description = "Availablity Zone 2 for subnets"
}

variable "elastic-private-ip-range" {
  default     = "10.10.1.5"
  type        = string
  description = "Elastic private IP address range for Nat Gateway"
}

variable "destination-cidr-block" {
  default     = "0.0.0.0/0"
  type        = string
  description = "Destination CIDR Block for Nat and Internet Gateway"
}

## ECS variables ##

variable "network_mode" {
  default     = "awsvpc"
  type        = string
  description = "task def network mode"
}

variable "samar_java_image" {
  default     = "527657010034.dkr.ecr.us-east-1.amazonaws.com/samar-ecr-java-prod:latest"
  type        = string
  description = "ESR docker image name for Java application"
}

variable "samar_angular_image_admin" {
  default     = "527657010034.dkr.ecr.us-east-1.amazonaws.com/samar-ecr-angular-admin-prod:latest"
  type        = string
  description = "ESR docker image name for Angular application"
}

variable "samar_angular_image_app1" {
  default     = "527657010034.dkr.ecr.us-east-1.amazonaws.com/samar-ecr-angular-app1-prod:latest"
  type        = string
  description = "ESR docker image name for Angular application"
}

variable "efs_ec2_instance_type" {
  default     = "t2.micro"
  type        = string
  description = "EC2 instance type for EFS instance"
}

variable "public_subnet_id" {
  default     = "aws_subnet.samar_pub_sub_1.id"
  type        = string
  description = "EC2 Instance for public subnet id"
}

 