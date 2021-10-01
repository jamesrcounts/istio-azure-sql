resource "azurerm_key_vault_secret" "exports" {
  for_each = {
    aks-cluster-name                    = module.aks.cluster_name
    evh-state-primary-connection-string = azurerm_storage_account.evh_state.primary_connection_string
    evh-configuration = jsonencode({
      name                      = local.evhns_name
      primary_connection_string = azurerm_eventhub_authorization_rule.rw.primary_connection_string
      topic                     = local.evh_name
    })
  }

  key_vault_id = module.configuration.key_vault_id
  name         = each.key
  value        = each.value
}