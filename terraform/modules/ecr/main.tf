data "aws_caller_identity" "current" {}

resource "aws_ecr_repository" "different" {
  count                = var.ecr_cnt
  name                 = var.ecr_repo_name
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

#resource "terraform_data" "dkr_pack" {
#  count = var.tf_data_dkr_pack ? 1 : 0
#  provisioner "local-exec" {
#    command = "bash ${path.module}/file.sh ${var.app_unit} ${var.account_id} ${var.region} ${var.ecr_repo_name} ${var.tag}"
#  }
#  triggers_replace = {
#    "run_at" = timestamp()
#  }
#}
