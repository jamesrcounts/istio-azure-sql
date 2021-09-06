resource "azurerm_key_vault_secret" "exports" {
  for_each = {
    aks-cluster-name = module.aks.cluster_name
  }

  key_vault_id = module.configuration.key_vault_id
  name         = each.key
  value        = each.value
}