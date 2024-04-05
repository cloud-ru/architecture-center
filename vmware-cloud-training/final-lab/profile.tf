# nsxt port profiles

resource "vcd_nsxt_app_port_profile" "tcp80" {
  name = "tcp80"
  scope = "TENANT"
  context_id = data.vcd_org_vdc.my_vdc.id
  app_port {
    protocol = "TCP"
    port = ["80"]
  }
}

resource "vcd_nsxt_app_port_profile" "tcp22" {
  name       = "tcp22"
  scope      = "TENANT"
  context_id = data.vcd_org_vdc.my_vdc.id

  app_port {
    protocol = "TCP"
    port     = ["22"]
  }
}
