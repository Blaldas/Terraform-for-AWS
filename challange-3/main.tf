locals {
  access_file = jsondecode(file("${path.module}/../access.json"))
  access_key  = local.access_file.Access_key_ID
  secret_key  = local.access_file.Secret_access_Key


ec2_web_server_id = module.ec2_module.ec2_web_server_id
}

provider "aws" {
  region     = "eu-west-1"
  access_key = local.access_key
  secret_key = local.secret_key
}

variable "sg_name"{
    type = string
    default = "web_ports_sg"
}

#---------------------------------------------------------------------------
#ec2 isntances
module "ec2_module" {
  # database server
  source     = "./ec2"
  ec2_db_tag = "DB Server"

  # web server
  ec2_web_server_tag       = "Web Server"
  ec2_web_server_user_data = "${path.module}/server-script.sh"
  ec2_web_server_sg_name   = var.sg_name
}

output "db_server_private_id" {
  value = module.ec2_module.db_server_private_id
}

#---------------------------------------------------------------------------

#elastic ip to ensure imutable public ip

module "elastic_ip_module" {
  # database server
  source                    = "./eip"
  aws_web_server_instace_ip = local.ec2_web_server_id#module.ec2_module.ec2_web_server_id
}

output "elastic_ip_public_ip" {
  value = module.elastic_ip_module.elastic_ip_public_ip
}

#---------------------------------------------------------------------------
#security groups

module "security_group_module" {
  # database server
  source    = "./sg"
  port_list = [80, 443]
  sg_name   = var.sg_name
}





