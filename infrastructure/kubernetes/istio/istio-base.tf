# helm install istio-base manifests/charts/base -n istio-system
resource "helm_release" "istio_base" {
  atomic    = true
  chart     = "${path.module}/charts/istio-1.11.2/manifests/charts/base"
  lint      = true
  name      = "istio-base"
  namespace = kubernetes_namespace.istio_system.metadata.0.name
}
