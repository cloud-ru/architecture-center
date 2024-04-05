# nsxt ipset

resource "vcd_nsxt_ip_set" "flab_app_set" {
  edge_gateway_id = data.vcd_nsxt_edgegateway.nsxt-edge.id
  name            = "flab-app-set"
  description     = var.flab_app_cidr
  ip_addresses    = [var.flab_app_cidr]
}

resource "vcd_nsxt_ip_set" "flab_web_set" {
  edge_gateway_id = data.vcd_nsxt_edgegateway.nsxt-edge.id
  name = "flab-web-set"
  description = var.flab_web_cidr
  ip_addresses = [var.flab_web_cidr]
}

resource "vcd_nsxt_ip_set" "edge_ip_set" {
  edge_gateway_id = data.vcd_nsxt_edgegateway.nsxt-edge.id
  name = "flab-edge-ip-set"
  description = data.vcd_nsxt_edgegateway.nsxt-edge.primary_ip
  ip_addresses = [data.vcd_nsxt_edgegateway.nsxt-edge.primary_ip]
}

