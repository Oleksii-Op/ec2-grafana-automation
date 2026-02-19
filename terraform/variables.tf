variable "debian-ami" {
  default = "ami-00ebb2b898eebe380"
  type = string
  description = "64 bit Debian 13 (HVM), EBS General Purpose (SSD) Volume Type. Community developed free GNU/Linux distribution. https://www.debian.org/"
}

variable "ubuntu-ami" {
  default = "ami-01f79b1e4a5c64257"
  type = string
  description = "Ubuntu Server 24.04 LTS (HVM),EBS General Purpose (SSD) Volume Type. Support available from Canonical (http://www.ubuntu.com/cloud/services)."
}

variable "ec2_ssh_pubkey_path" {
  type        = string
  default     = "/home/YOUR_USER/.ssh/aws_ec2.pub"
  description = "Path to EC2 SSH public key"
}

variable "ec2_ssh_private_path" {
  type        = string
  default     = "/home/YOUR_USER/.ssh/aws_ec2"
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
