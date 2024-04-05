# variables

variable "vcd_url" {}
variable "org_name" {}
variable "org_vdc" {}
variable "edge_name" {}
variable "vcd_storage_policy" {}
variable "ova" {}
variable "ssh_user" {}
variable "ssh_password" {}
variable "vcd_max_retry_timeout" {}
variable "vcd_allow_unverified_ssl" {}

variable "flab_web_ip-01" {}
variable "flab_web_ip-02" {}
variable "gateway_web_ip" {}
variable "flab_web_cidr" {}

variable "flab_app_ip-01" {}
variable "flab_app_ip-02" {}
variable "gateway_app_ip" {}
variable "flab_app_cidr" {}

variable "flab_web_port-01" {}
variable "flab_web_port-02" {}
variable "flab_app_port-01" {}
variable "flab_app_port-02" {}

# terraform

terraform {
  required_providers {
    vcd = {
      source  = "vmware/vcd"
      version = ">=3.10.0"
    }
  }
  required_version = ">= 1.5.5"
}

# provider

provider "vcd" {
  user                 = "none"
  password             = "none"
  auth_type            = "api_token_file"
  api_token_file       = "token.json"
  allow_api_token_file = true

  org                  = var.org_name
  vdc                  = var.org_vdc
  url                  = var.vcd_url
  max_retry_timeout    = var.vcd_max_retry_timeout
  allow_unverified_ssl = var.vcd_allow_unverified_ssl
}

# outputs

output "web-haproxy-stats" {
  value = "http://${data.vcd_nsxt_edgegateway.nsxt-edge.primary_ip}:${var.flab_app_port-01}"
}

output "web-haproxy" {
  value = "http://${data.vcd_nsxt_edgegateway.nsxt-edge.primary_ip}:${var.flab_app_port-02}"
}

output "web-vm-01" {
  value = "http://${data.vcd_nsxt_edgegateway.nsxt-edge.primary_ip}:${var.flab_web_port-01}"
}

output "web-vm-02" {
  value = "http://${data.vcd_nsxt_edgegateway.nsxt-edge.primary_ip}:${var.flab_web_port-02}"
}

output "ssh_haproxy" {
  value = data.vcd_nsxt_edgegateway.nsxt-edge.primary_ip
}

output "ssh_user" {
  value = var.ssh_user
}

output "ssh_password" {
  value = var.ssh_password
}
