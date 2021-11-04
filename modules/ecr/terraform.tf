terraform{
  backend "s3"{
    bucket = "bucket-terr"
    encrypt = true
    key = "AWS/dev/ecr/terraform.tfstate"
  }
}
provider "aws" {
  shared_credentials_file = var.cred
  region = var.region
}
