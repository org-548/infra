output "secret_arn" {
  value = aws_secretsmanager_secret.for_eks.arn
}

output "secret_version_id" {
  value = aws_secretsmanager_secret_version.this.version_id
}
