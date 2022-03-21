# Provides a Cloudflare Zone resource.
# Zone is the basic resource for working with Cloudflare and is roughly equivalent to a domain name that the user purchases.
resource "cloudflare_zone" "cf_example_zone" {
  zone = var.zone

  plan       = var.plan
  paused     = var.paused
  jump_start = var.jump_start
  type       = var.type
}
