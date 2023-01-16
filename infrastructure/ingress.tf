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
    selector = {
        app = "${var.app_name}"
        environment = "${var.environment}"
    }
  }
}

resource "kubernetes_ingress_v1" "example" {
  wait_for_load_balancer = true
  metadata {
    name = "example"
    annotations = {
      "alb.ingress.kubernetes.io/scheme" = "internet-facing"
      "alb.ingress.kubernetes.io/load-balancer-name" = "${var.environment}-${var.app_name}-alb-${var.AWS_REGION}"
    }
  }
  spec {
    ingress_class_name = "alb"
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