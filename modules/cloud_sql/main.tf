locals {
  #  databases = {
  #    for db_instance_name, database_list in var.dbs : db_instance_name => database_list.database
  #  }

  databases = flatten([
    for db_instance_name, database_list in var.dbs : [
      for database in database_list.database : {
        instance_name = db_instance_name
        database      = database
      }
    ]
  ])

  users = flatten([
    for db_instance_name, user_list in var.dbs : [
      for user in user_list.user : {
        instance_name = db_instance_name
        user      = user
      }
    ]
  ])

#    users = {
#      for db_instance_name, user_list in var.dbs : db_instance_name => user_list.user
#    }

}

resource "google_sql_database_instance" "sql_database_instance" {
  provider = google-beta

  for_each = var.dbs

  name                = each.key
  region              = lookup(each.value, "region")
  database_version    = lookup(each.value, "database_version", "MYSQL_5_7")
  deletion_protection = lookup(each.value, "deletion_protection", false)

  settings {
    tier              = lookup(each.value, "db_instance_tier", "db-f1-micro")
    availability_type = lookup(each.value, "availability_type", "REGIONAL")
    disk_type         = lookup(each.value, "disk_type", "PD_SSD")
    disk_size         = lookup(each.value, "disk_size", 10)
    disk_autoresize   = lookup(each.value, "disk_autoresize", true)

    ip_configuration {
      ipv4_enabled       = lookup(each.value, "public_access", true)
      private_network    = var.vpc_id
      allocated_ip_range = var.vpc_id != null ? lookup(each.value, "private_service_connection_name") : null
    }

    backup_configuration {
      binary_log_enabled = lookup(each.value, "binary_log_enabled", false)
      enabled            = lookup(each.value, "backup_enable", false) || lookup(each.value, "binary_log_enabled", false) ? true : false

      dynamic "backup_retention_settings" {
        for_each = lookup(each.value, "backup_enable", false) || lookup(each.value, "binary_log_enabled", false) ? { dummy : "dummy" } : {}
        content {
          retained_backups = 7
          retention_unit   = "COUNT"
        }
      }
    }
  }
}

resource "google_sql_database" "database" {
  count = length(local.databases)

  name     = local.databases[count.index].database
  instance = local.databases[count.index].instance_name

  depends_on = [google_sql_database_instance.sql_database_instance]
}

data "google_secret_manager_secret_version" "passwords" {
  count = length(local.users)

  secret = local.users[count.index].user
}

resource "google_sql_user" "users" {
  count = length(local.users)

  name     = local.users[count.index].user
  instance = local.users[count.index].instance_name
  host     = "%"
  password = data.google_secret_manager_secret_version.passwords[count.index].secret_data

  depends_on = [data.google_secret_manager_secret_version.passwords, google_sql_database_instance.sql_database_instance]
}
