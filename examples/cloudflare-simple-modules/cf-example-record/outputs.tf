output "cf_record_id" {
  description = "The record ID"
  value       = cloudflare_record.cf_example_record.id
}

output "cf_hostname" {
  description = "The FQDN of the record"
  value       = cloudflare_record.cf_example_record.hostname
}

output "cf_proxied" {
  description = "Shows whether this record can be proxied, must be true if setting proxied=true"
  value       = cloudflare_record.cf_example_record.proxied
}

output "cf_created_on" {
  description = "The RFC3339 timestamp of when the record was created"
  value       = cloudflare_record.cf_example_record.created_on
}

output "cf_modified_on" {
  description = "The RFC3339 timestamp of when the record was last modified"
  value       = cloudflare_record.cf_example_record.modified_on
}

output "cf_metadata" {
  description = "A key-value map of string metadata Cloudflare associates with the record"
  value       = cloudflare_record.cf_example_record.metadata
}
