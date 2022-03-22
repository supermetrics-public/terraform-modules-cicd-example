terraform {
  backend "local" {
    path = "terraform.tfstate"
  }
}

resource "random_string" "this" {
  length  = 6
  special = false
}

module "bucket_local_backup" {
  source = "../../"

  zone = "test-cf-${random_string.this.result}.local"
  plan = "free"
}
