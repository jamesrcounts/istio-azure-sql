resource "kubernetes_namespace" "ns" {
  for_each = toset(["apps", "svcs"])

  metadata {
    name = each.key

    labels = {
      "istio-injection" = "enabled"
    }
  }
}


resource "kubernetes_namespace" "legacy" {
  metadata {
    name = "legacy"
  }
}
