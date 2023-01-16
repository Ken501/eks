// Nginx Service
resource "kubernetes_service_v1" "nginx_service" {
  metadata {
    name = "${var.environment}-${var.app_name}-nginx-svc"
    namespace = "${var.environment}-${var.app_name}-ns-${var.AWS_REGION}"
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

// Nginx ingress
resource "kubernetes_ingress_v1" "nginx_ingress" {
  wait_for_load_balancer = true
  metadata {
    name = "${var.environment}-${var.app_name}-nginx-ingress"
    namespace = "${var.environment}-${var.app_name}-ns-${var.AWS_REGION}"
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
              name = kubernetes_service_v1.nginx_service.metadata.0.name
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