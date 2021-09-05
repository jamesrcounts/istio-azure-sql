# id=$(az sql server list \
#     --resource-group CreateSQLEndpointTutorial-rg \
#     --query '[].[id]' \
#     --output tsv)

# az network private-endpoint create \
#     --name myPrivateEndpoint \
#     --resource-group CreateSQLEndpointTutorial-rg \
#     --vnet-name myVNet --subnet myBackendSubnet \
#     --private-connection-resource-id $id \
#     --group-ids sqlServer \
#     --connection-name myConnection
# az network private-endpoint dns-zone-group create \
#    --resource-group CreateSQLEndpointTutorial-rg \
#    --endpoint-name myPrivateEndpoint \
#    --name MyZoneGroup \
#    --private-dns-zone "privatelink.database.windows.net" \
#    --zone-name sql
resource "azurerm_private_endpoint" "sql" {
  name                = "pe-${module.sql_private.server_name}"
  location            = data.azurerm_resource_group.main.location
  resource_group_name = data.azurerm_resource_group.main.name
  subnet_id           = module.network.subnets["ple-subnet"]
  tags                = local.tags

  private_dns_zone_group {
    name                 = "sql"
    private_dns_zone_ids = [azurerm_private_dns_zone.database.id]
  }

  private_service_connection {
    name                           = module.sql_private.server_name
    private_connection_resource_id = module.sql_private.server_id
    is_manual_connection           = false
    subresource_names              = ["sqlServer"]
  }
}

# az network private-dns zone create \
#     --resource-group CreateSQLEndpointTutorial-rg \
#     --name "privatelink.database.windows.net"
resource "azurerm_private_dns_zone" "database" {
  name                = "privatelink.database.windows.net"
  resource_group_name = data.azurerm_resource_group.main.name
  tags                = local.tags
}

# az network private-dns link vnet create \
#     --resource-group CreateSQLEndpointTutorial-rg \
#     --zone-name "privatelink.database.windows.net" \
#     --name MyDNSLink \
#     --virtual-network myVNet \
#     --registration-enabled false
resource "azurerm_private_dns_zone_virtual_network_link" "database" {
  name                  = module.network.virtual_network_name
  private_dns_zone_name = azurerm_private_dns_zone.database.name
  resource_group_name   = data.azurerm_resource_group.main.name
  virtual_network_id    = module.network.virtual_network_id
  tags                  = local.tags
}