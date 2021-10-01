locals {
  evh_name   = "evh-${local.instance_id}"
  evhns_name = "evhns-${local.instance_id}"
}

resource "azurerm_eventhub_namespace" "evhns" {
  name                = local.evhns_name
  location            = data.azurerm_resource_group.main.location
  resource_group_name = data.azurerm_resource_group.main.name
  sku                 = "Standard"
  capacity            = 1

  tags = local.tags
}

resource "azurerm_eventhub" "evh" {
  name                = local.evh_name
  namespace_name      = azurerm_eventhub_namespace.evhns.name
  resource_group_name = data.azurerm_resource_group.main.name
  partition_count     = 2
  message_retention   = 1
}

resource "azurerm_eventhub_authorization_rule" "rw" {
  name                = "rw"
  namespace_name      = azurerm_eventhub_namespace.evhns.name
  eventhub_name       = azurerm_eventhub.evh.name
  resource_group_name = data.azurerm_resource_group.main.name
  listen              = true
  send                = true
  manage              = false
}