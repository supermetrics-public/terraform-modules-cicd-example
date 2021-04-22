terraform {
  backend "local" {
    path = "terraform.tfstate"
  }
}

locals {
  profile        = "test"
  environment    = "test"
  server_cluster = "central"
  region         = "eu-west-1"
}

provider "aws" {
  profile = local.profile
  region  = local.region
}

resource "random_string" "this" {
  length  = 6
  special = false
}

module "test_simple_bucket" {
  source = "../../"

  bucket_postfix = "test-simple-bucket-${random_string.this.result}"

  environment    = local.environment
  profile        = local.profile
  server_cluster = local.server_cluster
}
