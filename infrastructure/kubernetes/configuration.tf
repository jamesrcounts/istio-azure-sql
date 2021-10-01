module "configuration" {
  source = "github.com/jamesrcounts/terraform-modules.git//configuration?ref=configuration-0.0.2"

  instance_id = var.backend_instance_id

  additional_imports = [
    "aks-cluster-name",
    "appenv-instance-id",
    "evh-configuration",
  ]
}
