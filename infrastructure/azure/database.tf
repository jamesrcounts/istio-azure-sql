resource "azurerm_mssql_database" "db" {
  for_each = {
    "std"     = module.sql_standard.server_id
    "proxy"   = module.sql_proxy.server_id
    "private" = module.sql_private.server_id
  }

  name           = "test-${each.key}"
  server_id      = each.value
  collation      = "SQL_Latin1_General_CP1_CI_AS"
  license_type   = "LicenseIncluded"
  max_size_gb    = 4
  read_scale     = true
  sku_name       = "BC_Gen5_2"
  zone_redundant = true
  tags           = local.tags
}