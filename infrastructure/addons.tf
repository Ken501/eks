// Cluster Add-ons
resource "aws_eks_addon" "coredns_addon" {
  cluster_name      = aws_eks_cluster.eks_cluster.name
  addon_name        = var.coredns_addon_version
}