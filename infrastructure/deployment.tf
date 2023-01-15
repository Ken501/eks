resource "kubernetes_deployment_v1" "nginx_deployment" {
  metadata {
    name = "${var.environment}-${var.app_name}-deploy"
    labels = {
      app = "${var.app_name}"
      env = "${var.environment}"
    }
  }

  spec {
    replicas = 3

    selector {
      match_labels = {
        app = "${var.app_name}"
        environment = "${var.environment}"
      }
    }

    template {
      metadata {
        labels = {
          app = "${var.app_name}"
          environment = "${var.environment}"
        }
      }

      spec {
        container {
          image = "nginx"
          name  = "${var.environment}-${var.app_name}-container"

          resources {
            limits = {
              cpu    = "0.5"
              memory = "512Mi"
            }
            requests = {
              cpu    = "250m"
              memory = "50Mi"
            }
          }

          liveness_probe {
            http_get {
              path = "/"
              port = 80

              http_header {
                name  = "X-Custom-Header"
                value = "Awesome"
              }
            }

            initial_delay_seconds = 3
            period_seconds        = 3
          }
        }
      }
    }
  }
}