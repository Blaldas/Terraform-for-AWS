terraform {
    backend "s3" {
    key= "terraform/tfstate.tfstate"
      bucket = "md-remote-backend-2022"
      region = "eu-west-1"
      access_key = "<replace with access key>"
      secret_key = "<replace with secret key>"
    }
}