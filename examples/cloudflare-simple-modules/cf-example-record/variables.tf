variable "data" {
  description = "(Optional) Map of attributes that constitute the record value. Primarily used for LOC and SRV record types. Either this or value must be specified"
  type        = list
  default     = []
}

variable "name" {
  description = "(Required) The name of the record"
  type        = string
}

variable "priority" {
  description = "(Optional) The priority of the record"
  type        = string
  default     = 1
}

variable "profile" {
  type        = string
  description = "AWS profile"
  default     = "demo"
}

variable "proxied" {
  description = "(Optional) Whether the record gets Cloudflare's origin protection; defaults to false."
  type        = string
  default     = false
}

variable "ttl" {
  description = "(Optional) The TTL of the record (automatic: '1')"
  type        = string
  default     = 1
}

variable "type" {
  description = "(Required) The type of the record"
  type        = string
  default     = "CNAME"
}

variable "value" {
  description = "(Optional) The (string) value of the record. Either this or data must be specified"
  type        = string

}

variable "zone_id" {
  description = "(Required) The DNS zone ID to add the record to"
  type        = string
}
