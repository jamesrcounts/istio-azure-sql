resource "kubernetes_service_account" "httpbin" {
  for_each = kubernetes_namespace.ns

  metadata {
    name      = "httpbin"
    namespace = each.value.metadata.0.name
  }
}

resource "kubernetes_service" "httpbin" {
  for_each = kubernetes_namespace.ns

  metadata {
    name      = "httpbin"
    namespace = each.value.metadata.0.name

    labels = {
      "app"     = "httpbin"
      "service" = "httpbin"
    }
  }

  spec {
    port {
      name        = "http"
      port        = 8000
      target_port = 80
    }

    selector = {
      app = "httpbin"
    }
  }
}

resource "kubernetes_deployment" "httpbin" {
  depends_on = [
    module.istio
  ]

  for_each = kubernetes_namespace.ns

  metadata {
    name      = "httpbin"
    namespace = each.value.metadata.0.name
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app     = "httpbin"
        version = "v1"
      }
    }

    template {
      metadata {
        labels = {
          app     = "httpbin"
          version = "v1"
        }
      }

      spec {
        service_account_name = "httpbin"
        container {
          image             = "docker.io/kennethreitz/httpbin"
          image_pull_policy = "IfNotPresent"
          name              = "httpbin"
          port {
            container_port = 80
          }

        }
      }
    }
  }
}