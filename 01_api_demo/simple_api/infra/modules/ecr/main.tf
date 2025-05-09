resource "aws_ecr_repository" "repository" {
  name                 = var.name
  image_tag_mutability = "MUTABLE"


  force_delete         = true
}
