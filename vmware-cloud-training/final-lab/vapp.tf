# vapp

resource "vcd_vapp" "flab-vapp-app" {
  name       = "flab-vapp-app"
  depends_on = [vcd_network_routed_v2.flab-net-app]
}

resource "vcd_vapp" "flab-vapp-web" {
  name = "flab-vapp-web"
  depends_on = [vcd_network_routed_v2.flab-net-web]
}
