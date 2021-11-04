terraform{
  backend "s3"{
    bucket = "bucket-terr"
    encrypt = true
    key = "AWS/dev/terraform.tfstate"
    dynamodb_table = "terraform"
  }
}
locals{
}
provider "aws" {
  shared_credentials_file = "~/.aws/credentials"
  region = var.region
}
