// Cluster Auth for kubernetes provider
data "aws_eks_cluster" "eks_cluster" {
  name = "${var.environment}-${var.app_name}-cluster-${var.AWS_REGION}"
}
data "aws_eks_cluster_auth" "cluster_auth" {
  name = "${var.environment}-${var.app_name}-cluster-${var.AWS_REGION}"
}