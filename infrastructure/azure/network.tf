module "network" {
  source = "github.com/jamesrcounts/terraform-modules.git//virtual-network?ref=virtual-network-1.0.2"

  environment             = "aks"
  resource_group          = data.azurerm_resource_group.main
  log_analytics_workspace = local.log_analytics_workspace

  subnets = {
    "aks-subnet" = {
      bits                    = 8
      net                     = 238
      enable_private_endpoint = false
    } // [8, 238]
    "ple-subnet" = {
      bits                    = 8
      net                     = 1
      enable_private_endpoint = true
    } //[8, 1]
  }
}