locals {
  server = {
    "std"     = module.sql_standard
    "proxy"   = module.sql_proxy
    "private" = module.sql_private
  }
}

resource "azurerm_mssql_database" "db" {
  for_each = local.server

  name           = "test-${each.key}"
  server_id      = each.value.server_id
  collation      = "SQL_Latin1_General_CP1_CI_AS"
  license_type   = "LicenseIncluded"
  max_size_gb    = 4
  read_scale     = true
  sku_name       = "BC_Gen5_2"
  zone_redundant = true
  tags           = local.tags
}

resource "azurerm_key_vault_secret" "connection_strings" {
  for_each = azurerm_mssql_database.db

  key_vault_id = module.configuration.key_vault_id
  name         = "${each.value.name}-connection-string"
  value        = "Server=tcp:${local.server[each.key].fully_qualified_domain_name},1433;Initial Catalog=${each.value.name};Persist Security Info=False;User ID=${local.server[each.key].administrator_login};Password=${local.server[each.key].administrator_login_password};MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;"
}