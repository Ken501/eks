// Ingress Controller Class
# resource "kubernetes_ingress_class_v1" "ingress_class" {
#   metadata {
#     name = "${var.environment}-${var.app_name}-ingress-class"
#   }

#   spec {
#     controller = "kmartinez.net/ingress-controller"
#     parameters {
#       kind      = "IngressParameters"
#       name      = "${var.environment}-${var.app_name}-external-alb-${var.AWS_REGION}"
#     }
#   }
# }

resource "kubernetes_service_v1" "example" {
  metadata {
    name = "ingress-service"
  }
  spec {
    port {
      port        = 80
      target_port = 80
      protocol    = "TCP"
    }
    type = "NodePort"
  }
}

resource "kubernetes_ingress_v1" "example" {
  wait_for_load_balancer = false
  metadata {
    name = "ingress-example"
  }
  spec {
    ingress_class_name = "nginx"
    rule {
      http {
        path {
          path = "/*"
          backend {
            service {
              name = kubernetes_service_v1.example.metadata.0.name
              port {
                number = 80
              }
            }
          }
        }
      }
    }
  }
}

# Display load balancer hostname (typically present in AWS)
output "load_balancer_hostname" {
  value = kubernetes_ingress_v1.example.status.0.load_balancer.0.ingress.0.hostname
}

# Display load balancer IP (typically present in GCP, or using Nginx ingress controller)
output "load_balancer_ip" {
  value = kubernetes_ingress_v1.example.status.0.load_balancer.0.ingress.0.ip
}