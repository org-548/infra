resource "aws_secretsmanager_secret" "for_eks" {
  name                    = var.secret_name
  description             = var.secret_desc
  recovery_window_in_days = var.recovery_days

  tags = {
    Name = var.secret_tag
  }
}

resource "aws_secretsmanager_secret_version" "this" {
  secret_id     = aws_secretsmanager_secret.for_eks.id
  secret_string = jsonencode(var.secret)
}

