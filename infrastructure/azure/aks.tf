module "aks" {
  source = "github.com/jamesrcounts/terraform-modules.git//aks?ref=aks-0.0.3"

  log_analytics_workspace = local.log_analytics_workspace
  resource_group          = data.azurerm_resource_group.main
  subnet                  = { id = module.network.subnets["aks-subnet"] }
  resource_suffix         = "aks"
  admin_group_object_id   = module.configuration.imports["admin-group-object-id"]
}