// prometheous helm release
resource "helm_release" "prometheous_release" {
  name       = "prometheous"
  namespace  = "prometheous"
  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "prometheous"

}