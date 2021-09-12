module "sql_standard" {
  source = "./sql"

  admin_group_object_id = module.configuration.imports["admin-group-object-id"]
  resource_group        = data.azurerm_resource_group.main
  primary_blob_endpoint = azurerm_storage_account.audits.primary_blob_endpoint
}

resource "azurerm_sql_firewall_rule" "allow_aks" {
  name                = "allow-all"
  resource_group_name = data.azurerm_resource_group.main.name
  server_name         = module.sql_standard.server_name
  start_ip_address    = module.aks.load_balancer_ip_address
  end_ip_address      = module.aks.load_balancer_ip_address
}