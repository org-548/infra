resource "aws_ecr_repository" "different" {
  count                = var.ecr_cnt
  name                 = var.ecr_repo_name[count.index]
  force_delete         = var.force_delete
  image_tag_mutability = var.mutability
}

data "template_file" "policy" {
  template = file("${path.module}/templates/lifecycle-policy.json.tpl")
}

resource "aws_ecr_lifecycle_policy" "example" {
  count      = var.ecr_cnt
  repository = aws_ecr_repository.different[count.index].name
  policy     = data.template_file.policy.rendered
}

