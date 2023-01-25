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

resource "aws_db_instance" "myRDS" {
  db_name                = "myDB"
  identifier          = "my-first-rds"
  instance_class      = "db.t2.micro"
  engine              = "mariadb"
  engine_version      = "10.2.21"
  username            = "MD"
  password            = "password123"
  port                = 3306
  allocated_storage   = 20
  skip_final_snapshot = true

}
