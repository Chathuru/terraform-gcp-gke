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

module "redis" {
  source                  = "./modules/google_redis"
  name                    = "private"
  tier                    = "STANDARD_HA"
  memory_size_gb          = 5
  location_id             = "us-central1-a"
  alternative_location_id = "us-central1-f"
  vpc_id                  = module.vpc.vpc_id
  connect_mode            = "PRIVATE_SERVICE_ACCESS"
  redis_version           = "REDIS_4_0"
}
