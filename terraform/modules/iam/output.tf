output "s3_pol_doc_json" {
  value = data.aws_iam_policy_document.access_to_s3[0].json
}

#output "eks_role_arn" {
#  value = aws_iam_role.for_eks[0].arn
#}
#
#output "eks_trusted_policy_id" {
#  value = aws_iam_role.for_eks[0].id
#}
#
#output "eks_trusted_policy_arn" {
#  value = aws_iam_role.for_eks[0].arn
#}
#
#output "node_group_role_arn" {
#  value = aws_iam_role.for_node_group[0].arn
#}
#
#output "node_group_role_id" {
#  value = aws_iam_role.for_node_group[0].id
#}
#
#output "node_group_role_name" {
#  value = aws_iam_role.for_node_group[0].name
#}
#
#output "oidc_provider_arn" {
#  value = aws_iam_openid_connect_provider.for_eks_oidc[0].arn
#}
#
#output "sm_access_policy_arn" {
#  value = aws_iam_policy.access_to_secrets_manager[0].arn
#}
#
#output "sm_access_policy_id" {
#  value = aws_iam_policy.access_to_secrets_manager[0].id
#}
