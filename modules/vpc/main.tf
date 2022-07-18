locals {
  private_subnets = flatten([
    for region, cidrs in var.private_subnets : [
      for name, cidr in cidrs : {
        subnet_region = region
        subnet_name = name
        subnet_cidr = cidr
      }
    ]
  ])
}

resource "google_compute_network" "vpc_network" {
  project                 = var.project_name
  name                    = join("-", [var.environment, var.vpc_name])
  auto_create_subnetworks = var.auto_create_subnetworks
  routing_mode            = var.routing_mode
}

resource "google_compute_subnetwork" "private_subnets" {
  count = !var.auto_create_subnetworks && length(local.private_subnets) > 0 ? length(local.private_subnets) : 0

  name          = local.private_subnets[count.index].subnet_name
  ip_cidr_range = local.private_subnets[count.index].subnet_cidr
  region        = local.private_subnets[count.index].subnet_region
  private_ip_google_access = true
  network       = google_compute_network.vpc_network.id

  depends_on = [google_compute_network.vpc_network]
}
