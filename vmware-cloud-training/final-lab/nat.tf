# nat

resource "vcd_nsxt_nat_rule" "snat" {
  edge_gateway_id = data.vcd_nsxt_edgegateway.nsxt-edge.id

  name      = "flab-snat-rule"
  rule_type = "SNAT"

  external_address = data.vcd_nsxt_edgegateway.nsxt-edge.primary_ip
  internal_address = var.flab_app_cidr
}

resource "vcd_nsxt_nat_rule" "dnat1" {
  edge_gateway_id = data.vcd_nsxt_edgegateway.nsxt-edge.id
  name = "flab-dnat-rule-web-01"
  rule_type = "DNAT"

  external_address = data.vcd_nsxt_edgegateway.nsxt-edge.primary_ip
  dnat_external_port = var.flab_web_port-01
  internal_address = var.flab_web_ip-01
  app_port_profile_id = vcd_nsxt_app_port_profile.tcp80.id
  depends_on = [vcd_nsxt_app_port_profile.tcp80]
}

resource "vcd_nsxt_nat_rule" "dnat2" {
  edge_gateway_id = data.vcd_nsxt_edgegateway.nsxt-edge.id
  name = "flab-dnat-rule-web-02"
  rule_type = "DNAT"

  external_address = data.vcd_nsxt_edgegateway.nsxt-edge.primary_ip
  dnat_external_port = var.flab_web_port-02
  internal_address = var.flab_web_ip-02
  app_port_profile_id = vcd_nsxt_app_port_profile.tcp22.id
  depends_on = [vcd_nsxt_app_port_profile.tcp22]
}

resource "vcd_nsxt_nat_rule" "dnat3" {
  edge_gateway_id = data.vcd_nsxt_edgegateway.nsxt-edge.id
  name = "flab-dnat-rule-app-01"
  rule_type = "DNAT"

  external_address = data.vcd_nsxt_edgegateway.nsxt-edge.primary_ip
  dnat_external_port = var.flab_app_port-01
  internal_address = var.flab_app_ip-01
  app_port_profile_id = vcd_nsxt_app_port_profile.tcp80.id
  depends_on = [vcd_nsxt_app_port_profile.tcp80]
}

resource "vcd_nsxt_nat_rule" "dnat4" {
  edge_gateway_id = data.vcd_nsxt_edgegateway.nsxt-edge.id
  name = "flab-dnat-rule-app-02"
  rule_type = "DNAT"

  external_address = data.vcd_nsxt_edgegateway.nsxt-edge.primary_ip
  dnat_external_port = var.flab_app_port-02
  internal_address = var.flab_app_ip-02
  app_port_profile_id = vcd_nsxt_app_port_profile.tcp80.id
  depends_on = [vcd_nsxt_app_port_profile.tcp80]
}

resource "vcd_nsxt_nat_rule" "dnat5" {
  edge_gateway_id = data.vcd_nsxt_edgegateway.nsxt-edge.id
  name = "flab-dnat-rule-ssh"
  rule_type = "DNAT"

  external_address = data.vcd_nsxt_edgegateway.nsxt-edge.primary_ip
  dnat_external_port = "22"
  internal_address = var.flab_app_ip-01
  app_port_profile_id = vcd_nsxt_app_port_profile.tcp22.id
  depends_on = [vcd_nsxt_app_port_profile.tcp22]
}
