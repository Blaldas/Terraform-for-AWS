variable "port_list" {
  type = list(number)
}

variable "sg_name" {
  type = string
}


resource "aws_security_group" "web_ports" {
  name = var.sg_name
  dynamic "ingress" {
    for_each = var.port_list
    content {
      cidr_blocks = ["0.0.0.0/0"]
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "TCP"
    }
  }

  dynamic "egress" {
    for_each = var.port_list
    content {
      cidr_blocks = ["0.0.0.0/0"]
      from_port   = egress.value
      to_port     = egress.value
      protocol    = "TCP"
    }
  }

}
