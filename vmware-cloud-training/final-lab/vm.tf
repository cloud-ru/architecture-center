# vms

resource "vcd_vapp_vm" "flab-vm-web-01" {
  vapp_name = vcd_vapp.flab-vapp-web.name
  name = "flab-vm-web-01"
  vapp_template_id = vcd_catalog_vapp_template.ova.id
  memory = 384
  cpus = 1
  accept_all_eulas = "true"
  depends_on = [vcd_vapp.flab-vapp-web, vcd_vapp_org_network.vapp_web_network]

  network {
    type = "org"
    name = vcd_network_routed_v2.flab-net-web.name
    ip_allocation_mode = "POOL"
    is_primary = "true"
    connected = "true"
  }

  customization {
    enabled = "true"
    allow_local_admin_password = "true"
    auto_generate_password = "false"
    admin_password = var.ssh_password
    initscript = "mkdir /tmp/node && cd /tmp/node && /usr/bin/python3 -m http.server 80 &"
  }
}

resource "vcd_vapp_vm" "flab-vm-web-02" {
  vapp_name = vcd_vapp.flab-vapp-web.name
  name = "flab-vm-web-02"
  vapp_template_id = vcd_catalog_vapp_template.ova.id
  memory = 384
  cpus = 1
  accept_all_eulas = "true"
  depends_on = [vcd_vapp.flab-vapp-web, vcd_vapp_org_network.vapp_web_network]

  network {
    type = "org"
    name = vcd_network_routed_v2.flab-net-web.name
    ip_allocation_mode = "POOL"
    is_primary = "true"
    connected = "true"
  }

  customization {
    enabled = "true"
    allow_local_admin_password = "true"
    auto_generate_password = "false"
    admin_password = var.ssh_password
    initscript = "mkdir /tmp/node && cd /tmp/node && /usr/bin/python3 -m http.server 80 &"
  }
}

resource "vcd_vapp_vm" "flab-vm-app" {
  vapp_name = vcd_vapp.flab-vapp-app.name
  name = "flab-vm-app"
  vapp_template_id = vcd_catalog_vapp_template.ova.id
  memory = 384
  cpus = 1
  accept_all_eulas = "true"
  depends_on = [vcd_vapp.flab-vapp-app, vcd_vapp_org_network.vapp_app_network,vcd_vapp_vm.flab-vm-web-01, vcd_vapp_vm.flab-vm-web-02]

  network {
    type = "org"
    name = vcd_network_routed_v2.flab-net-app.name
    ip_allocation_mode = "POOL"
    is_primary = "true"
    connected = "true"
  }

  network {
    type = "org"
    name = vcd_network_routed_v2.flab-net-app.name
    ip_allocation_mode = "POOL"
    is_primary = "false"
    connected = "false"
  }

  customization {
    enabled = "true"
    allow_local_admin_password = "true"
    auto_generate_password = "false"
    admin_password = var.ssh_password
  }
}