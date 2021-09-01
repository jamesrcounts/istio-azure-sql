module "network" {
  source = "github.com/jamesrcounts/terraform-modules.git//virtual-network?ref=virtual-network-0.0.1"

  environment             = "aks"
  resource_group          = data.azurerm_resource_group.main
  log_analytics_workspace = local.log_analytics_workspace

  subnets = {
    "aks-subnet" = [8, 238]
  }
}