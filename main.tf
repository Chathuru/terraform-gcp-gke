provider "google" {
  project = var.project_name
  region  = "us-central1"
  zone    = "us-central1-c"
}

provider "google-beta" {
  alias   = "beta"
  project = var.project_name
  region  = "us-central1"
  zone    = "us-central1-c"
}

module "vpc" {
  source          = "./modules/vpc"
  project_name    = var.project_name
  vpc_name        = "vpc"
  environment     = "dev"
  private_subnets = var.private_subnets
}

module "private-service-connections" {
  source = "./modules/private_service_connection"
  providers = {
    google-beta = google-beta.beta
  }
  vpc_id             = module.vpc.vpc_id
  private_ip_address = var.private_ip_address
}

module "sql" {
  source = "./modules/cloud_sql"
  providers = {
    google-beta = google-beta.beta
  }
  name                = "sql"
  region              = "us-central1"
  database_version    = "MYSQL_8_0"
  deletion_protection = false
}

#resource "google_redis_instance" "cache" {
#  name           = "private-cache"
#  tier           = "STANDARD_HA" #BASIC
#  memory_size_gb = 5 # STANDARD_HA=5 BASIC=1
#
#  location_id             = "us-central1-a"
#  alternative_location_id = "us-central1-f"
#  auth_enabled = false
#
#  authorized_network = module.vpc.vpc_id
#  connect_mode       = "PRIVATE_SERVICE_ACCESS" #DIRECT_PEERING
#
#  redis_version     = "REDIS_4_0" # STANDARD_HA version 5 or higher
#  display_name      = "Terraform Test Instance"
#
#  depends_on = [google_service_networking_connection.private_vpc_connection_mysql]
#
#}
