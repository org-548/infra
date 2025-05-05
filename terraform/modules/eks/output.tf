output "cluster_id" {
  value = aws_eks_cluster.this[0].id
}

output "cluster_arn" {
  value = aws_eks_cluster.this[0].arn
}

output "cluster_name" {
  value = aws_eks_cluster.this[0].name
}

output "cluster_endpoint" {
  value = aws_eks_cluster.this[0].endpoint
}

output "cluster_cert" {
  value = aws_eks_cluster.this[0].certificate_authority.0.data
}

output "cert_authority" {
  value = aws_eks_cluster.this[0].certificate_authority
}

output "cluster_identity" {
  value = aws_eks_cluster.this[0].identity
}

output "cluster_identity_issuer" {
  value = aws_eks_cluster.this[0].identity[0].oidc[0].issuer
}

output "cluster_status" {
  value = aws_eks_cluster.this[0].status
}

output "access_entry_arn" {
  value = aws_eks_access_entry.for_local_access[0].access_entry_arn
}

output "access_entry_created" {
  value = aws_eks_access_entry.for_local_access[0].created_at
}

output "access_entry_modified" {
  value = aws_eks_access_entry.for_local_access[0].modified_at
}

output "node_group_arn" {
  value = aws_eks_node_group.this[0].arn
}

output "node_group_id" {
  value = aws_eks_node_group.this[0].id
}

output "node_group_res" {
  value = aws_eks_node_group.this[0].resources
}

output "node_group_status" {
  value = aws_eks_node_group.this[0].status
}

