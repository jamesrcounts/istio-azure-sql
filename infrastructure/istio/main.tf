locals {
  instance_id = nonsensitive(module.configuration.imports["appenv-instance-id"])
  kube_config = data.azurerm_kubernetes_cluster.aks.kube_admin_config.0
}
