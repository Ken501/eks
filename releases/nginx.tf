resource "helm_release" "nginx" {
  chart      = "nginx"
  name       = "nginx-deploy"
  namespace  = "${var.environment}-${var.app_name}-ns-${var.AWS_REGION}"
  repository = "https://https://ken501.github.io/gitchartrepo/"
  version    = "0.1.0"

}
