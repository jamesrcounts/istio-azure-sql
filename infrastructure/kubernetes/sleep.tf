resource "kubernetes_service_account" "sleep" {
  for_each = kubernetes_namespace.ns

  metadata {
    name      = "sleep"
    namespace = each.value.metadata.0.name
  }
}

resource "kubernetes_service" "sleep" {
  for_each = kubernetes_namespace.ns

  metadata {
    name      = "sleep"
    namespace = each.value.metadata.0.name

    labels = {
      "app"     = "sleep"
      "service" = "sleep"
    }
  }

  spec {
    port {
      name = "http"
      port = 80
    }

    selector = {
      app = "sleep"
    }
  }
}

resource "kubernetes_deployment" "sleep" {
  depends_on = [
    module.istio
  ]

  for_each = kubernetes_namespace.ns

  metadata {
    name      = "sleep"
    namespace = each.value.metadata.0.name
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "sleep"
      }
    }

    template {
      metadata {
        labels = {
          app = "sleep"
        }
      }

      spec {
        service_account_name             = "sleep"
        termination_grace_period_seconds = 0
        container {
          command           = ["/bin/sleep", "3650d"]
          image             = "curlimages/curl"
          image_pull_policy = "IfNotPresent"
          name              = "sleep"
          port {
            container_port = 80
          }
          volume_mount {
            mount_path = "/etc/sleep/tls"
            name       = "secret-volume"
          }
        }
        volume {
          name = "secret-volume"
          secret {
            secret_name = "sleep-secret"
            optional    = true
          }
        }
      }
    }
  }
}