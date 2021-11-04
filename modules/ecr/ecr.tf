resource "aws_ecr_repository" "app" {
  name = local.ecr_repository_name
}
