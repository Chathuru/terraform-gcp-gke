resource "google_redis_instance" "redis_instance" {
  name                    = var.name
  display_name            = var.display_name
  tier                    = var.tier
  memory_size_gb          = var.memory_size_gb
  location_id             = var.location_id
  alternative_location_id = var.alternative_location_id
  auth_enabled            = var.auth_enabled
  authorized_network      = var.vpc_id
  connect_mode            = var.connect_mode
  redis_version           = var.redis_version
}
