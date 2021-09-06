# helm install istio-egress manifests/charts/gateways/istio-egress \
#     -n istio-system
resource "helm_release" "istio_egress" {
  atomic    = true
  chart     = "${path.module}/charts/istio-1.11.2/manifests/charts/gateways/istio-egress"
  lint      = true
  name      = "istio-egress"
  namespace = helm_release.istio_discovery.metadata.0.namespace
}
