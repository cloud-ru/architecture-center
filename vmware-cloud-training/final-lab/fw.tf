# nsxt firewall

resource "vcd_nsxt_firewall" "rules" {
  edge_gateway_id = data.vcd_nsxt_edgegateway.nsxt-edge.id
  depends_on = [vcd_nsxt_ip_set.flab_web_set, vcd_nsxt_ip_set.flab_app_set]

  rule {
    action      = "ALLOW"
    name        = "flab-app-to-internet"
    direction   = "IN_OUT"
    ip_protocol = "IPV4"
    source_ids  = [vcd_nsxt_ip_set.flab_app_set.id]
  }

  rule {
    action      = "ALLOW"
    name        = "flab-web-to-internet"
    direction   = "IN_OUT"
    ip_protocol = "IPV4"
    source_ids  = [vcd_nsxt_ip_set.flab_web_set.id]
  }

  rule {
    action               = "ALLOW"
    name                 = "flab-ssh-from-internet"
    direction            = "IN_OUT"
    ip_protocol          = "IPV4"
    destination_ids      = [vcd_nsxt_ip_set.flab_app_set.id]
    app_port_profile_ids = [vcd_nsxt_app_port_profile.tcp22.id]
  }

  rule {
    action = "ALLOW"
    name = "flab-web-from-internet"
    direction = "IN_OUT"
    ip_protocol = "IPV4"
    destination_ids = [vcd_nsxt_ip_set.flab_web_set.id, vcd_nsxt_ip_set.flab_app_set.id]
    app_port_profile_ids = [vcd_nsxt_app_port_profile.tcp80.id]
  }
}
