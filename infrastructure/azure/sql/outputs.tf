output "administrator_login" {
  value = azurerm_mssql_server.server.administrator_login
}

output "administrator_login_password" {
  value     = azurerm_mssql_server.server.administrator_login_password
  sensitive = true
}

output "fully_qualified_domain_name" {
  value = azurerm_mssql_server.server.fully_qualified_domain_name
}

output "server_id" {
  value = azurerm_mssql_server.server.id
}

output "server_name" {
  value = azurerm_mssql_server.server.name
}