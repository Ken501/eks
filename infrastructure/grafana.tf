// Grafana
resource "helm_release" "grafana" {
  chart      = "grafana"
  name       = "grafana"
  repository = "https://grafana.github.io/helm-charts"
  namespace  = "monitoring"
  version    = "6.24.1"

}