
resource "azurerm_mssql_server" "server" {
  name                         = local.server_name
  resource_group_name          = var.resource_group.name
  location                     = var.resource_group.location
  version                      = "12.0"
  administrator_login          = "missadministrator"
  administrator_login_password = random_password.admin_password.result
  minimum_tls_version          = "1.2"
  tags                         = var.resource_group.tags

  azuread_administrator {
    login_username = "AzureAD Admin"
    object_id      = var.admin_group_object_id
  }

  identity {
    type = "SystemAssigned"
  }
}

resource "azurerm_mssql_server_extended_auditing_policy" "auditing" {
  depends_on        = [azurerm_role_assignment.sql_audit]
  server_id         = azurerm_mssql_server.server.id
  storage_endpoint  = var.primary_blob_endpoint
  retention_in_days = 6
}

resource "random_password" "admin_password" {
  length           = 16
  min_lower        = 1
  min_numeric      = 1
  min_special      = 1
  min_upper        = 1
  override_special = "_%@"
  special          = true
}

resource "azurerm_role_assignment" "sql_audit" {
  principal_id         = azurerm_mssql_server.server.identity.0.principal_id
  role_definition_name = "Storage Blob Data Contributor"
  scope                = var.resource_group.id
}