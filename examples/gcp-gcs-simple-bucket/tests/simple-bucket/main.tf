terraform {
  backend "local" {
    path = "terraform.tfstate"
  }
}

locals {
  project_id     = "supermetrics-dev-sandbox"
  environment    = "test"
  server_cluster = "central"
  region         = "europe-west1"
}

provider "google" {
  project = local.project_id
  region  = local.region
}

resource "random_string" "this" {
  length  = 6
  special = false
}

module "bucket_local_backup" {
  source = "../../"

  environment    = local.environment
  server_cluster = local.server_cluster

  bucket_name     = "test-gcp-simple-bucket-${random_string.this.result}"
  project_id      = local.project_id
  bucket_location = local.region

  storage_class = "STANDARD"
}
