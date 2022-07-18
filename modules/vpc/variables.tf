variable "project_name" {
  type = string
}
variable "environment" {
  type = string
}
variable "vpc_name" {
  type = string
}
variable "auto_create_subnetworks" {
  type = bool
  default = false
}
variable "routing_mode" {
  type = string
  default = "REGIONAL"
  validation {
    condition = var.routing_mode == "REGIONAL" || var.routing_mode == "GLOBAL"
    error_message = "Accepted values are \"REGIONAL\" and \"GLOBAL\"."
  }
}
variable "private_subnets" {
  type = map
  default = {}
}
variable "public_subnets" {
  type = map
  default = {}
}
