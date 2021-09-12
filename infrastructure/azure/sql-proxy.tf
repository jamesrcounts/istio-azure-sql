module "sql_proxy" {
  source = "./sql"

  admin_group_object_id = module.configuration.imports["admin-group-object-id"]
  resource_group        = data.azurerm_resource_group.main
  primary_blob_endpoint = azurerm_storage_account.audits.primary_blob_endpoint
  connection_policy     = "Proxy"
  resource_suffix       = "proxy"
}

resource "azurerm_sql_firewall_rule" "all_access_proxy" {
  name                = "allow-all"
  resource_group_name = data.azurerm_resource_group.main.name
  server_name         = module.sql_proxy.server_name
  start_ip_address    = "0.0.0.0"
  end_ip_address      = "255.255.255.255"
}