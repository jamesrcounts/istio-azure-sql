locals {
  env_instance_id         = module.configuration.imports["appenv-instance-id"]
  log_analytics_workspace = module.configuration.log_analytics_workspace
}
