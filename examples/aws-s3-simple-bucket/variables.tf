variable "block_public_acls" {
  type        = string
  description = "(Optional) Whether Amazon S3 should block public ACLs for this bucket."
  default     = true
}

variable "block_public_policy" {
  type        = string
  description = "(Optional) Whether Amazon S3 should block public bucket policies for this bucket."
  default     = true
}

variable "bucket_acl" {
  type        = string
  description = "(Optional) The canned ACL to apply. ( private / public-read / public-read-write / aws-exec-read / etc )"
  default     = "private"
}

variable "bucket_postfix" {
  type        = string
  description = "S3 bucket name postfix."
}

variable "environment" {
  type        = string
  description = "Server environment (stage / prod / ...)"
}

variable "force_destroy" {
  description = "A boolean that indicates whether all objects should be deleted from the bucket so that the bucket can be destroyed without error. These objects are not recoverable."
  default     = false
}

variable "ignore_public_acls" {
  type        = string
  description = "(Optional) Whether Amazon S3 should ignore public ACLs for this bucket."
  default     = true
}

variable "lifecycle_rule" {
  type        = list
  description = "List of maps containing configuration of object lifecycle management."
  default     = []
}

variable "profile" {
  type        = string
  description = "AWS profile"
}

variable "restrict_public_buckets" {
  type        = string
  description = "(Optional) Whether Amazon S3 should restrict public bucket policies for this bucket."
  default     = true
}

variable "server_cluster" {
  type        = string
  description = "Supermetrics server cluster (eu1 / us1 / ...)"
}

variable "versioning_enabled" {
  type        = string
  description = "Versioning to keep multiple variants of an object in the same bucket."
  default     = false
}
