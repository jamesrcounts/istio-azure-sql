resource "azurerm_storage_account" "audits" {
  access_tier               = "Cool"
  account_kind              = "StorageV2"
  account_replication_type  = "GRS"
  account_tier              = "Standard"
  allow_blob_public_access  = false
  enable_https_traffic_only = true
  is_hns_enabled            = false
  large_file_share_enabled  = false
  location                  = data.azurerm_resource_group.main.location
  min_tls_version           = "TLS1_2"
  name                      = substr(replace("sa-${local.instance_id}", "-", ""), 0, 24)
  resource_group_name       = data.azurerm_resource_group.main.name
  tags                      = local.tags

  blob_properties {
    delete_retention_policy {
      days = 7
    }
  }

  identity {
    type = "SystemAssigned"
  }

  network_rules {
    bypass = [
      "AzureServices",
    ]
    default_action             = "Deny"
    ip_rules                   = []
    virtual_network_subnet_ids = []
  }
}

resource "azurerm_storage_account" "evh_state" {
  name                     = replace("sa-evh-${local.instance_id}", "-", "")
  resource_group_name      = data.azurerm_resource_group.main.name
  location                 = data.azurerm_resource_group.main.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = local.tags
}

resource "azurerm_storage_container" "evh" {
  name                  = "evh"
  storage_account_name  = azurerm_storage_account.evh_state.name
  container_access_type = "private"
}