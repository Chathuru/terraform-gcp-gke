resource "google_sql_database_instance" "sql_database_instance" {
  provider = google-beta

  name                = var.name
  region              = var.region
  database_version    = var.database_version
  deletion_protection = var.deletion_protection

  settings {
    tier              = var.db_instance_tier
    availability_type = var.availability_type
    disk_type         = var.disk_type
    disk_size         = var.disk_size
    disk_autoresize   = var.disk_autoresize

    ip_configuration {
      ipv4_enabled       = var.public_access
      private_network    = var.vpc_id != null ? var.vpc_id : null
      allocated_ip_range = var.private_service_connection_name != null ? var.private_service_connection_name : null
    }

    backup_configuration {
      binary_log_enabled = var.binary_log_enabled
      enabled            = var.backup_enable || var.binary_log_enabled ? true : var.backup_enable

      dynamic "backup_retention_settings" {
        for_each = var.backup_enable || var.binary_log_enabled ? { dummy : "dummy" } : {}
        content {
          retained_backups = var.retained_backups
          retention_unit   = var.retention_unit
        }
      }
    }
  }
}
