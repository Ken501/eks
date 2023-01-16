// Network Policy Object
resource "kubernetes_network_policy_v1" "example" {
  metadata {
    name      = "${var.environment}-${var.app_name}-netpol-${var.AWS_REGION}"
    namespace = "${var.environment}-${var.app_name}-ns-${var.AWS_REGION}"
  }

  spec {
    pod_selector {
      match_expressions {
        key      = "app"
        operator = "In"
        values   = ["${var.app_name}"]
      }
    }

    ingress {
      ports {
        port     = "http"
        protocol = "TCP"
      }
      ports {
        port     = "22"
        protocol = "TCP"
      }

      from {
        namespace_selector {
          match_labels = {
            name = "${var.environment}-${var.app_name}-ns-${var.AWS_REGION}"
          }
        }
      }
    }

    egress {} # single empty rule to allow all egress traffic

    policy_types = ["Ingress", "Egress"]
  }
}