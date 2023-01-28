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

module "db"{
    source = "./db"
    count = 3

    ec2_db_tag = "db-server-${count.index + 1}"
}

output "db_server_private_id" {
  value = [module.db.*.db_server_private_id]
}