data "azurerm_resource_group" "main" {
  name = "rg-${local.instance_id}"
}

