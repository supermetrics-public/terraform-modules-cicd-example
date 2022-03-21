# Add a record to the domain
resource "cloudflare_record" "cf_example_record" {
  zone_id  = var.zone_id
  name     = var.name
  value    = var.value
  proxied  = var.proxied
  priority = var.priority
  type     = var.type
  ttl      = var.ttl
}
