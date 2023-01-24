variable "ec2_db_tag" {
  type = string
}

resource "aws_instance" "db_server" {
  ami           = "ami-0fe0b2cf0e1f25c8a"
  instance_type = "t2.micro"

  tags = {
    Name = var.ec2_db_tag
  }
}
# output #database server private ip
output "db_server_private_id" {
  value = aws_instance.db_server.private_ip
}
