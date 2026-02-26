variable "ec2_ssh_pubkey_path" {
  type        = string
  default     = "/home/main/.ssh/aws_ec2.pub"
  description = "Path to EC2 SSH public key"
}

variable "ec2_ssh_private_path" {
  type        = string
  default     = "/home/main/.ssh/aws_ec2"
  description = "Path to EC2 SSH private key"
}

variable "instance_type" {
  type = string
  default = "t3.micro"
}

variable "region" {
  type = string
  default = "eu-central-1"
  description = "Sets AWS region"
}
