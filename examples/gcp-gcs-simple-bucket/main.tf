locals {
  fully_qualified_bucket_name = "${lower(var.server_cluster)}-${lower(var.environment)}-${lower(var.bucket_name)}"
}

module "bucket" {
  source  = "terraform-google-modules/cloud-storage/google//modules/simple_bucket"
  version = "~> 10.0.0"

  name       = local.fully_qualified_bucket_name
  project_id = var.project_id
  location   = var.bucket_location

  versioning    = var.versioning
  storage_class = var.storage_class

  retention_policy = var.retention_policy
  lifecycle_rules  = var.lifecycle_rules

  force_destroy = var.force_destroy
  encryption    = var.encryption

  iam_members = var.iam_members

  // GCP only accept hyphen (-), underscore (_) and alphanumeric characters (0-9a-Z)
  labels = {
    environment    = lower(var.environment)
    project_id     = lower(var.project_id)
    provider       = "gcp"
    service        = "gcs"
    managed_by     = "terraform"
    server_cluster = lower(var.server_cluster)
    name           = local.fully_qualified_bucket_name
  }
}
