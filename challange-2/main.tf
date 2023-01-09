locals{
    access_file = jsondecode(file("${path.module}/../access.json"))
    access_key = local.access_file.Access_key_ID
    secret_key = local.access_file.Secret_access_Key
}

provider "aws" {
    region="eu-west-1"
    access_key = local.access_key
    secret_key = local.secret_key
}

#---------------------------------------------------------------------------
# database server
resource "aws_instance" "db_server" {
    ami = "ami-0fe0b2cf0e1f25c8a"
    instance_type = "t2.micro"

    tags = {
      Name = "DB Server"
    }
}
# output #database server private ip
output "db_server_private_id" {
    value = aws_instance.db_server.private_ip
}
#---------------------------------------------------------------------------

# web server
resource "aws_instance" "web_server" {
    ami = "ami-0fe0b2cf0e1f25c8a"
    instance_type = "t2.micro"
    security_groups = [ aws_security_group.web_ports.name ]
    user_data = file("${path.module}/server-script.sh")

    tags = {
      Name = "Web Server"
    }
}

#elastic ip to ensure imutable public ip
resource "aws_eip" "elasticeip"{
    instance = aws_instance.web_server.id
}
#---------------------------------------------------------------------------

variable "port_list" {
  type = list(number)
  default = [ 80, 443 ]
}

resource "aws_security_group" "web_ports"{
    name = "web_ports_sg"
    dynamic "ingress" {
        for_each = var.port_list
        content{
            cidr_blocks = [ "0.0.0.0/0" ]
            from_port = ingress.value
            to_port = ingress.value
            protocol = "TCP"
        }
    }

    dynamic "egress" {
        for_each = var.port_list
        content{
            cidr_blocks = [ "0.0.0.0/0" ]
            from_port = egress.value
            to_port = egress.value
            protocol = "TCP"
        }
    }

}

output "elastic_ip_public_ip" {
    value = aws_eip.elasticeip.public_ip
}

