resource "helm_release" "prometheus" {
  chart      = "prometheus"
  name       = "prometheus"
  namespace  = "prometheus"
  repository = "https://prometheus-community.github.io/helm-charts"
  version    = "15.5.3"

  values = [
    templatefile("${path.module}/templates/prometheus-values.yaml", {
      pod_security_enabled             = true
      server_persistent_volume_enabled = false
      server_resources_limits_cpu      = "256m"
      server_resources_limits_memory   = "256Mi"
      server_resources_requests_cpu    = "256m"
      server_resources_requests_memory = "256Mi"
    })
  ]
}