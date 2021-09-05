locals {
  instance_id             = nonsensitive(module.configuration.imports["appenv-instance-id"])
  log_analytics_workspace = module.configuration.log_analytics_workspace
  tags                    = data.azurerm_resource_group.main.tags
}
