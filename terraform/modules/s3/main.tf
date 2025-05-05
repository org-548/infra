resource "aws_s3_bucket" "this" {
  count         = var.bucket_cnt
  bucket        = var.bucket_name
  force_destroy = var.destroy

  tags = {
    Name = var.bucket_tag
  }
}

resource "aws_s3_bucket_acl" "this" {
  count                 = var.acl_cnt
  bucket                = aws_s3_bucket.this[count.index].id
  acl                   = var.acl
  expected_bucket_owner = var.expected_owner_id

  depends_on = [aws_s3_bucket_ownership_controls.this]
}

resource "aws_s3_bucket_ownership_controls" "this" {
  count  = var.ownership_definiton_cnt
  bucket = aws_s3_bucket.this[count.index].id
  rule {
    object_ownership = var.obj_ownership
  }
}

resource "aws_s3_bucket_public_access_block" "this" {
  count  = var.access_definition_cnt
  bucket = aws_s3_bucket.this[count.index].id

  block_public_acls       = var.block_public_acls
  block_public_policy     = var.block_public_policy
  ignore_public_acls      = var.ignore_public_acls
  restrict_public_buckets = var.restrict_public_buckets
}

resource "aws_s3_bucket_versioning" "this" {
  count  = var.versioning_res_cnt
  bucket = aws_s3_bucket.this[count.index].id
  versioning_configuration {
    status = var.versioning
    #mfa_delete = var.mfa_delete
  }
}

resource "aws_s3_bucket_policy" "this" {
  count  = var.policy_cnt
  bucket = aws_s3_bucket.this[0].id
  policy = var.s3_policy
}

