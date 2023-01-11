locals {
  access_file = jsondecode(file("${path.module}/../access.json"))
  access_key  = local.access_file.Access_key_ID
  secret_key  = local.access_file.Secret_access_Key
}

provider "aws" {
  region     = "eu-west-1"
  access_key = local.access_key
  secret_key = local.secret_key
}

resource "aws_instance" "ec2" {
  ami            = "ami-0fe0b2cf0e1f25c8a"
  instance_type  = "t2.micro"
  security_group = [aws_security_group.security_group.name]
}

variable "ingress" {
  type    = list(number)
  default = [80, 443, 3306, 8080]
}

variable "egress" {
  type    = list(number)
  default = [443, 80]
}

resource "aws_security_group" "security_group" {
  name = "Allow HTTPS"

  dynamic "ingress" {
    for_each = var.ingress
    content {
      from_port   = 443
      to_port     = 443
      protocol    = "TCP"
      cidr_blocks = "0.0.0.0/0"
    }
  }

  dynamic "egress" {
    for_each = var.egress
    content {
      from_port   = 443
      to_port     = 443
      protocol    = "TCP"
      cidr_blocks = "0.0.0.0/0"
    }
  }
}
