resource "helm_release" "fluent_bit" {
  atomic    = true
  chart     = "${path.module}/charts/fluent-bit-0.18.0"
  lint      = true
  name      = "fluent-bit"
  namespace = kubernetes_namespace.logging.metadata.0.name
}

resource "kubernetes_namespace" "logging" {
  metadata {
    name = "logging"
  }
}
