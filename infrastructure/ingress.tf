resource "kubernetes_service" "deploy_svc" {
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

resource "kubernetes_ingress" "deploy_ingress" {
  wait_for_load_balancer = false
  metadata {
    name = "${var.environment}-${var.app_name}-deploy"
    annotations = {
      "alb.ingress.kubernetes.io/scheme" = "internet-facing"
      "alb.ingress.kubernetes.io/load-balancer-name" = "${var.environment}-${var.app_name}-alb-${var.AWS_REGION}"
    }
  }
  spec {
    rule {
      http {
        path {
          path = "/*"
          backend {
            service_name = kubernetes_service.deploy_svc.metadata.0.name
            service_port = 80
          }
        }
      }
    }
  }
}

# Display load balancer hostname (typically present in AWS)
output "load_balancer_hostname" {
  value = kubernetes_ingress.deploy_ingress.status.0.load_balancer.0.ingress.0.hostname
}

# Display load balancer IP (typically present in GCP, or using Nginx ingress controller)
output "load_balancer_ip" {
  value = kubernetes_ingress.deploy_ingress.status.0.load_balancer.0.ingress.0.ip
}