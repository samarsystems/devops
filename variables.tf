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
