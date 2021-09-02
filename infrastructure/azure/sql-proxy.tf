module "sql_proxy" {
  source = "./sql"

  admin_group_object_id = module.configuration.imports["admin-group-object-id"]
  resource_group        = data.azurerm_resource_group.main
  primary_blob_endpoint = azurerm_storage_account.audits.primary_blob_endpoint
  connection_policy     = "Proxy"
  resource_suffix       = "proxy"
}