data "azurerm_resource_group" "main" {
  name = "rg-${local.env_instance_id}"
}

