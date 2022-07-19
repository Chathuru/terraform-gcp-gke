variable "name" {
  type = string
}

variable "display_name" {
  type    = string
  default = ""
}

variable "tier" {
  type = string

  validation {
    condition     = var.tier == "STANDARD_HA" || var.tier == "BASIC"
    error_message = "Valid values are STANDARD_HA and BASIC."
  }
}

variable "memory_size_gb" {
  type = number

  #  validation {
  #    condition     = var.tier == "STANDARD_HA" && var.memory_size_gb >= 5 || var.tier == "BASIC" && var.memory_size_gb >= 1
  #    error_message = "Memory size should be 5GB or more for STANDARD_HA tier and 1GB or more for BASIC tier."
  #  }
}

variable "auth_enabled" {
  type    = bool
  default = false
}

variable "vpc_id" {
  type = string
}

variable "connect_mode" {
  type = string

  #  validation {
  #    condition     = var.connect_mode == "PRIVATE_SERVICE_ACCESS" || var.connect_mode == "DIRECT_PEERING"
  #    error_message = "Valid values are PRIVATE_SERVICE_ACCESS and DIRECT_PEERING."
  #  }
}

variable "location_id" {
  type = string

  #  validation {
  #    condition     = var.location_id != var.alternative_location_id
  #    error_message = "Variable vales location_id and alternative_location_id should not be equal."
  #  }
}

variable "alternative_location_id" {
  type = string

  #  validation {
  #    condition     = var.location_id != var.alternative_location_id
  #    error_message = "Variable vales location_id and alternative_location_id should not be equal."
  #  }
}

variable "redis_version" {
  type = string

  validation {
    condition     = can(regex("REDIS_\\d_\\w", var.redis_version)) && split("_", var.redis_version)[1] >= 3
    error_message = "Redis version error."
  }
}
