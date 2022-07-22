#variable "name" {
#  type = string
#}
#
#variable "region" {
#  type = string
#}
#
#variable "database_version" {
#  type    = string
#  default = "MYSQL_5_7"
#
#  validation {
#    condition     = contains(["MYSQL_5_6", "MYSQL_5_7", "MYSQL_8_0", "POSTGRES_9_6", "POSTGRES_10", "POSTGRES_11", "POSTGRES_12", "POSTGRES_13", "POSTGRES_14"], var.database_version)
#    error_message = "Database version is not valid."
#  }
#}
#
#variable "deletion_protection" {
#  type    = bool
#  default = true
#}
#
#variable "db_instance_tier" {
#  type    = string
#  default = "db-f1-micro"
#}
#
#variable "availability_type" {
#  type    = string
#  default = "REGIONAL"
#
#  validation {
#    condition     = var.availability_type == "REGIONAL" || var.availability_type == "ZONE"
#    error_message = "Should be REGIONAL or ZONE."
#  }
#}
#
#variable "disk_type" {
#  type    = string
#  default = "PD_SSD"
#
#  validation {
#    condition     = var.disk_type == "PD_SSD" || var.disk_type == "PD_HDD"
#    error_message = "Should be PD_SSD or PD_HDD."
#  }
#}
#
#variable "disk_size" {
#  type    = number
#  default = 10
#}
#
#variable "disk_autoresize" {
#  type    = bool
#  default = true
#}
#
#variable "public_access" {
#  type    = bool
#  default = true
#}
#
variable "vpc_id" {
  type    = string
  default = null
}
#
#variable "private_service_connection_name" {
#  type    = string
#  default = null
#}
#
#variable "backup_enable" {
#  type    = bool
#  default = false
#}
#
#variable "binary_log_enabled" {
#  type    = bool
#  default = false
#}
#
#variable "retained_backups" {
#  type    = number
#  default = 7
#}
#
#variable "retention_unit" {
#  type    = number
#  default = 7
#}

variable "dbs" {}
