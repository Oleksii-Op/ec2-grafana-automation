terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.81.0"
    }
  }
  required_version = "1.14.6"
}

provider "aws" {
  region = var.region
}