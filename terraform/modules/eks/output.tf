output "eks_trusted_policy_id" {
  value = aws_iam_role.for_eks.id
}

output "eks_trusted_policy_arn" {
  value = aws_iam_role.for_eks.arn
}

output "cluster_id" {
  value = aws_eks_cluster.this.id
}

output "cluster_arn" {
  value = aws_eks_cluster.this.arn
}

output "cert_authority" {
  value = aws_eks_cluster.this.certificate_authority
}

output "cluster_endpoint" {
  value = aws_eks_cluster.this.endpoint
}

output "cluster_identity" {
  value = aws_eks_cluster.this.identity
}

output "cluster_status" {
  value = aws_eks_cluster.this.status
}

output "access_entry_arn" {
  value = aws_eks_access_entry.for_local_access.access_entry_arn
}

output "access_entry_created" {
  value = aws_eks_access_entry.for_local_access.created_at
}

output "access_entry_modified" {
  value = aws_eks_access_entry.for_local_access.modified_at
}

output "node_group_role_arn" {
  value = aws_iam_role.for_node_group.arn
}

output "node_group_role_id" {
  value = aws_iam_role.for_node_group.id
}

output "node_group_role_name" {
  value = aws_iam_role.for_node_group.name
}

output "node_group_arn" {
  value = aws_eks_node_group.this.arn
}

output "node_group_id" {
  value = aws_eks_node_group.this.id
}

output "node_group_res" {
  value = aws_eks_node_group.this.resources
}

output "node_group_status" {
  value = aws_eks_node_group.this.status
}

output "oidc_provider_arn" {
  value = aws_iam_openid_connect_provider.for_eks_oidc.arn
}

output "sm_access_policy_arn" {
  value = aws_iam_policy.access_to_secrets_manager.arn
}

output "sm_access_policy_id" {
  value = aws_iam_policy.access_to_secrets_manager.id
}

