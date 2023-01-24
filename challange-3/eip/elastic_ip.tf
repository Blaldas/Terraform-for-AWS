variable "aws_web_server_instace_ip" {
  type = string
}

resource "aws_eip" "elasticeip" {
  instance = var.aws_web_server_instace_ip #aws_instance.web_server.id
}

output "elastic_ip_public_ip" {
  value = aws_eip.elasticeip.public_ip
}
