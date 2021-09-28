resource "helm_release" "csi_secrets_store" {
  atomic    = true
  chart     = "${path.module}/charts/csi-secrets-store-provider-azure-0.2.1"
  lint      = true
  name      = "csi-secrets-store"
  namespace = kubernetes_namespace.secrets_store_csi_driver.metadata.0.name
}

resource "kubernetes_namespace" "secrets_store_csi_driver" {
  metadata {
    name = "secrets-store-csi-driver"
  }
}
