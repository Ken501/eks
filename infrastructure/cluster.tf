// EKS cluster
resource "aws_eks_cluster" "eks_cluster" {
  name     = "${var.environment}-${var.app_name}-cluster-${var.AWS_REGION}"
  role_arn = aws_iam_role.cluster_role.arn

  vpc_config {
    subnet_ids = [aws_subnet.public01.id, aws_subnet.public02.id]
  }

  depends_on = [
    aws_iam_role_policy_attachment.AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.AmazonEKSVPCResourceController,
  ]
}