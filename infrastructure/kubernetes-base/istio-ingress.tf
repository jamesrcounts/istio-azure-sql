# helm install istio-ingress manifests/charts/gateways/istio-ingress \
#     -n istio-system
resource "helm_release" "istio_ingress" {
  atomic    = true
  chart     = "${path.module}/charts/istio-1.11.2/manifests/charts/gateways/istio-ingress"
  lint      = true
  name      = "istio-ingress"
  namespace = helm_release.istio_discovery.metadata.0.namespace
}
