// NameSpaces

resource "kubernetes_namespace" "app_namespace" {
  metadata {
    name = "${var.environment}-${var.app_name}-ns-${var.AWS_REGION}"
  }
}

resource "kubernetes_namespace" "monitoring_namespace" {
  metadata {
    name = "monitoring"
  }
}