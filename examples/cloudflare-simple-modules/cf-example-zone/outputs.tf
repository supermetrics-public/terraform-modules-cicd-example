output "cf_zone_id" {
  description = "The zone ID."
  value       = cloudflare_zone.cf_example_zone.id
}

output "cf_plan" {
  description = "The name of the commercial plan to apply to the zone."
  value       = cloudflare_zone.cf_example_zone.plan
}

output "cf_status" {
  description = "Status of the zone. Valid values: active, pending, initializing, moved, deleted, deactivated."
  value       = cloudflare_zone.cf_example_zone.status
}

output "cf_name_servers" {
  description = "Cloudflare-assigned name servers. This is only populated for zones that use Cloudflare DNS."
  value       = cloudflare_zone.cf_example_zone.name_servers
}
