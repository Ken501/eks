// Cluster Add-ons

//CoreDNS
resource "aws_eks_addon" "coredns_addon" {
  cluster_name      = aws_eks_cluster.eks_cluster.name
  addon_name        = "coredns"
}

// EBS
resource "aws_eks_addon" "ebs_addon" {
  cluster_name      = aws_eks_cluster.eks_cluster.name
  addon_name        = "aws-ebs-csi-driver"
}
#Test