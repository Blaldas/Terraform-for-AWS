# Terraform-for-AWS


In order for the code to work a file called "access.json" must be created in the root folder of this project.
The file must have the following stucture:

{
    "Access_key_ID": "<Access_key_ID>",
    "Secret_access_Key": "<Secret_access_Key>"
}

backend/backend.tf - replace the access and secret keys to make it work. Addicionally, a backend.conf file can be used in order not to allow not to have the keys in code 
