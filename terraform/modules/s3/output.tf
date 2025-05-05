output "bucket_id" {
  value = aws_s3_bucket.this.*.id
}

output "bucket_arn" {
  value = aws_s3_bucket.this.*.arn
}

output "bucket_domain_name" {
  value = aws_s3_bucket.this.*.bucket_domain_name
}

output "bucket_acl_id" {
  value = aws_s3_bucket_acl.this.*.id
}

output "ownership_control_id" {
  value = aws_s3_bucket_ownership_controls.this.*.id
}

output "block_pub_access_id" {
  value = aws_s3_bucket_public_access_block.this.*.id
}

output "versioning_id" {
  value = aws_s3_bucket_versioning.this.*.id
}

