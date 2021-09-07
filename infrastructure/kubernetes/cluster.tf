data "azurerm_kubernetes_cluster" "aks" {
  name                = module.configuration.imports["aks-cluster-name"]
  resource_group_name = data.azurerm_resource_group.main.name
}