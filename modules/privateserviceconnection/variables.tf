variable "vpc_id" {
  type = string
}
variable "private_ip_address" {
  type = list(map(string))
}
variable "address_type" {
  type = string
  default = "INTERNAL"

  validation {
    condition = var.address_type == "INTERNAL" || var.address_type == "EXTERNAL"
    error_message = "Should be \"INTERNAL\" or \"EXTERNAL\"."
  }
}
variable "purpose" {
  type = string
  default = "VPC_PEERING"

  validation {
    condition = var.purpose == "VPC_PEERING" || var.purpose == "PRIVATE_SERVICE_CONNECT"
    error_message = "Should be \"VPC_PEERING\" or \"PRIVATE_SERVICE_CONNECT\"."
  }
}

