provider "aws"{
    region= "eu-west-1"

}

resource "aws_vpc" "myvpc"{
    cidr_block = "10.0.0.0/16"

}

output "hello"{
    value = "hello world"
}