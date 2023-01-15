// Ingress Controller Class
resource "kubernetes_ingress_class_v1" "ingress_controller" {
  metadata {
    name = "${var.environment}-${var.app_name}-ingress-controller"
  }

  spec {
    controller = "example.com/ingress-controller"
    parameters {
      kind      = "IngressParameters"
      name      = "${var.environment}-${var.app_name}-external-alb-${var.AWS_REGION}"
    }
  }
}