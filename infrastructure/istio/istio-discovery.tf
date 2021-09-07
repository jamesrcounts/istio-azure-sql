# helm install istiod manifests/charts/istio-control/istio-discovery \
#     -n istio-system
resource "helm_release" "istio_discovery" {
  atomic    = true
  chart     = "${path.module}/charts/istio-1.11.2/manifests/charts/istio-control/istio-discovery"
  lint      = true
  name      = "istiod"
  namespace = helm_release.istio_base.metadata.0.namespace // to ensure this deploy runs after the base deploy

  set {
    name  = "meshConfig.accessLogFile"
    value = "/dev/stdout"
  }
}
