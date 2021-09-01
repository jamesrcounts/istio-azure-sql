module "aks" {
  source = "github.com/jamesrcounts/terraform-modules.git//aks?ref=aks-0.0.1"

  log_analytics_workspace = local.log_analytics_workspace
  resource_group          = data.azurerm_resource_group.main
  subnet                  = { id = module.network.subnets["aks-subnet"] }
  environment             = "aks"
}