data "aws_caller_identity" "current" {}

resource "aws_s3_bucket" "sm-s3-bucket-data" {
  bucket = "${var.profile}-${var.server_cluster}-${var.environment}-${var.bucket_postfix}"
  acl  = var.bucket_acl

  force_destroy = var.force_destroy

  # This is a bit horrid
  dynamic "lifecycle_rule" {
    for_each = var.lifecycle_rule
    content {
      id                                     = lookup(lifecycle_rule.value, "id", null)
      prefix                                 = lookup(lifecycle_rule.value, "prefix", null)
      tags                                   = lookup(lifecycle_rule.value, "tags", null)
      abort_incomplete_multipart_upload_days = lookup(lifecycle_rule.value, "abort_incomplete_multipart_upload_days", null)
      enabled                                = lifecycle_rule.value.enabled

      dynamic "expiration" {
        for_each = length(keys(lookup(lifecycle_rule.value, "expiration", {}))) == 0 ? [] : [lookup(lifecycle_rule.value, "expiration", {})]

        content {
          days                         = lookup(expiration.value, "days", null)
          expired_object_delete_marker = lookup(expiration.value, "expired_object_delete_marker", null)
        }
      }

      # Several blocks - transition
      dynamic "transition" {
        for_each = lookup(lifecycle_rule.value, "transition", [])

        content {
          date          = lookup(transition.value, "date", null)
          days          = lookup(transition.value, "days", null)
          storage_class = transition.value.storage_class
        }
      }

    }
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  versioning {
    enabled = var.versioning_enabled
  }

  tags = {
    AccountId     = data.aws_caller_identity.current.account_id
    Environment   = var.environment
    Profile       = var.profile
    ServerCluster = var.server_cluster
  }
}

resource "aws_s3_bucket_public_access_block" "sm-s3-bucket-data-public-access" {
  bucket = aws_s3_bucket.sm-s3-bucket-data.id

  block_public_acls       = var.block_public_acls
  block_public_policy     = var.block_public_policy
  ignore_public_acls      = var.ignore_public_acls
  restrict_public_buckets = var.restrict_public_buckets
}
