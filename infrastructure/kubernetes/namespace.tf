resource "kubernetes_namespace" "ns" {
  for_each = toset(["apps", "svcs"])

  metadata {
    name = each.key

    labels = {
      "istio-injection" = "enabled"
    }
  }
}


# kubectl create ns bar
# kubectl apply -f <(istioctl kube-inject -f samples/httpbin/httpbin.yaml) -n bar
# kubectl apply -f <(istioctl kube-inject -f samples/sleep/sleep.yaml) -n bar
