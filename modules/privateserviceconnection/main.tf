locals {
    private_ip_range_names = flatten([
    for region in var.private_ip_address : [
      region.name
    ]
  ])
}

resource "google_compute_global_address" "private_ip_address" {
  count = length(var.private_ip_address)
  provider = google-beta

  name          = lookup(var.private_ip_address[count.index], "name")
  purpose       = var.purpose
  address_type  = var.address_type
  prefix_length = lookup(var.private_ip_address[count.index], "prefix_length", 24)
  address       = lookup(var.private_ip_address[count.index], "address", null)
  network       = var.vpc_id
  labels        = {}
}

resource "google_service_networking_connection" "private_service_connection" {
  provider = google-beta

  network                 = var.vpc_id
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = local.private_ip_range_names
}
