resource "helm_release" "prometheus" {
  chart      = "prometheus"
  name       = "prometheus"
  namespace  = "prometheus"
  repository = "https://prometheus-community.github.io/helm-charts"
  version    = "19.0.0"

  set {
    name  = "podSecurityPolicy.enabled"
    value = true
  }

  set {
    name  = "server.persistentVolume.enabled"
    value = false
  }

  set {
    name  = "alertmanager.enabled"
    value = false
  }

  set {
    name  = "kube-state-metrics.enabled"
    value = true
  }

  set {
    name  = "prometheus-node-exporter.enabled"
    value = true
  }

  set {
    name  = "prometheus-pushgateway.enabled"
    value = true
  }

}