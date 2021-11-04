variable "az_count" {
  default = 2
}
variable "env" {
  default = "dev"
}
variable "region" {
  default = "us-east-2"
}
variable "latest_ami_forubuntu" {
  default = "ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"
}
variable "owner_for_ubuntu" {
  default = "099720109477"
}
variable "cidrblock_for_vpc" {
  default = "10.0.0.0/16"
}
variable "destination" {
  default = "0.0.0.0/0"
}
variable "app_port" {
  default = "80"
}
variable "cred" {
  default = "~/.aws/credentials"
}
variable "owner" {
  default = "Koval Ilya"
}
variable "app_protocol" {
  default = "HTTP"
}
