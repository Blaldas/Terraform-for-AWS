provider "aws" {
      region= "eu-west-1"
}
resource "aws_vpc" "TerraformVPC" {
    cidr_block = "192.168.0.0/24"
  
}