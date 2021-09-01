module "configuration" {
  source = "github.com/jamesrcounts/terraform-modules.git//configuration?ref=configuration-0.0.1"

  instance_id = var.backend_instance_id

  additional_imports = [
    "appenv-instance-id",
    "admin-group-object-id",
    "msi-resource-id",
  ]
}
