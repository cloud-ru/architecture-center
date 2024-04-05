# catalog

resource "vcd_catalog" "flab_catalog" {
  name             = "flab-catalog"
  delete_force     = "true"
  delete_recursive = "true"
}

resource "vcd_catalog_vapp_template" "ova" {
  catalog_id  = vcd_catalog.flab_catalog.id
  name        = "flab-template"
  description = "PhotonOS 4.0 GA"
  ova_path    = "./${var.ova}"
}
