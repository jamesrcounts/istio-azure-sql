module "sql_private" {
  source = "./sql"

  admin_group_object_id         = module.configuration.imports["admin-group-object-id"]
  primary_blob_endpoint         = azurerm_storage_account.audits.primary_blob_endpoint
  public_network_access_enabled = false
  resource_group                = data.azurerm_resource_group.main
  resource_suffix               = "private"
}