// Cluster Outputs
output "endpoint" {
  value = aws_eks_cluster.eks_cluster.endpoint
}

output "kubeconfig-certificate-authority-data" {
  value = aws_eks_cluster.eks_cluster.certificate_authority[0].data
}

// Ingress outputs
# output "load_balancer_hostname" {
#   value = kubernetes_ingress_v1.nginx_ingress.status.0.load_balancer.0.ingress.0.hostname
# }

# output "load_balancer_ip" {
#   value = kubernetes_ingress_v1.nginx_ingress.status.0.load_balancer.0.ingress.0.ip
# }