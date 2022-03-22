variable "jump_start" {
  description = "(Optional) Boolean of whether to scan for DNS records on creation. Ignored after zone is created. Default: false."
  type        = string
  default     = false
}

variable "name_servers" {
  description = "Cloudflare-assigned name servers. This is only populated for zones that use Cloudflare DNS."
  default     = []
}

variable "paused" {
  description = "(Optional) Boolean of whether this zone is paused (traffic bypasses Cloudflare). Default: false."
  type        = string
  default     = false
}

variable "plan" {
  description = "(Optional) The name of the commercial plan to apply to the zone, can be updated once the one is created; one of free, pro, business, enterprise."
  type        = string
  default     = "pro"
}

variable "profile" {
  type        = string
  description = "AWS profile"
  default     = "demo"
}

variable "type" {
  description = "A full zone implies that DNS is hosted with Cloudflare. A partial zone is typically a partner-hosted zone or a CNAME setup. Valid values: full, partial. Default is full."
  type        = string
  default     = "partial"
}

variable "zone" {
  description = "(Required) The DNS zone name which will be added."
  type        = string
}
