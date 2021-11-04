locals{
  ecr_repository_name = format("%s", var.env)
}
variable "env" {
  default = "prod"
}
variable "cred" {
  default = "~/.aws/credentials"
}
variable "region" {
  default = "us-east-2"
}
