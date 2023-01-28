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

resource "aws_vpc" "test" {
  cidr_block = "10.0.0.0/16"
}