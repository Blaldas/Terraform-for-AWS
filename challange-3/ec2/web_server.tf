variable "ec2_web_server_tag" {
  type = string
}

variable "ec2_web_server_user_data" {
  type = string
}

variable "ec2_web_server_sg_name" {
  type = string
}

output "ec2_web_server_id" {
  value = aws_instance.web_server.id
}

resource "aws_instance" "web_server" {
  ami             = "ami-0fe0b2cf0e1f25c8a"
  instance_type   = "t2.micro"
  security_groups = [var.ec2_web_server_sg_name]
  user_data       = file(var.ec2_web_server_user_data)

  tags = {
    Name = var.ec2_web_server_tag
  }
}
