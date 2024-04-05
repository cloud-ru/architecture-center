# nsxt edge

data "vcd_org_vdc" "my_vdc" {
  name = var.org_vdc
}

data "vcd_nsxt_edgegateway" "nsxt-edge" {
  name = var.edge_name
  owner_id = data.vcd_org_vdc.my_vdc.id
}

# nsxt networks

resource "vcd_network_routed_v2" "flab-net-web" {
  name = "flab-net-web"
  edge_gateway_id = data.vcd_nsxt_edgegateway.nsxt-edge.id

  gateway = var.gateway_web_ip
  prefix_length = 24

  static_ip_pool {
    start_address = var.flab_web_ip-01
    end_address   = var.flab_web_ip-02
  }
}

resource "vcd_network_routed_v2" "flab-net-app" {
  name            = "flab-net-app"
  edge_gateway_id = data.vcd_nsxt_edgegateway.nsxt-edge.id

  gateway       = var.gateway_app_ip
  prefix_length = 24

  static_ip_pool {
    start_address = var.flab_app_ip-01
    end_address   = var.flab_app_ip-02
  }
}

# vapp networks

resource "vcd_vapp_org_network" "vapp_app_network" {
  vapp_name              = vcd_vapp.flab-vapp-app.name
  org_network_name       = vcd_network_routed_v2.flab-net-app.name
  depends_on             = [vcd_vapp.flab-vapp-app]
  reboot_vapp_on_removal = true
}

resource "vcd_vapp_org_network" "vapp_web_network" {
  vapp_name = vcd_vapp.flab-vapp-web.name
  org_network_name = vcd_network_routed_v2.flab-net-web.name
  depends_on = [vcd_vapp.flab-vapp-web]
  reboot_vapp_on_removal = true
}
