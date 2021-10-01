resource "azurerm_key_vault_secret" "exports" {
  for_each = {
    aks-cluster-name                    = module.aks.cluster_name
    evh-primary-connection-string       = azurerm_eventhub_authorization_rule.rw.primary_connection_string
    evh-state-primary-connection-string = azurerm_storage_account.evh_state.primary_connection_string
  }

  key_vault_id = module.configuration.key_vault_id
  name         = each.key
  value        = each.value
}