resource "helm_release" "prometheus" {
  chart      = "nginx"
  name       = "nginx"
  namespace  = "${var.environment}-${var.app_name}-ns-${var.AWS_REGION}"
  repository = "https://https://ken501.github.io/gitchartrepo/"
  version    = "0.1.0"

}