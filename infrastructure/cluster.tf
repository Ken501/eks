// EKS cluster
resource "aws_eks_cluster" "eks_cluster" {
  name     = "${var.environment}-${var.app_name}-cluster-${var.AWS_REGION}"
  role_arn = aws_iam_role.cluster_role.arn
  version  = var.kubernetes_version

  vpc_config {
    subnet_ids             = local.public_subnet_ids[*]
    endpoint_public_access = true
  }

  depends_on = [
    aws_iam_role_policy_attachment.AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.AmazonEKSVPCResourceController,
  ]
}

// Nodes

resource "aws_eks_node_group" "node_group" {
  cluster_name    = aws_eks_cluster.eks_cluster.name
  node_group_name = "${var.environment}-${var.app_name}-node-grp-${var.AWS_REGION}"
  node_role_arn   = aws_iam_role.node_role.arn
  subnet_ids      = local.private_subnet_ids[*]

  scaling_config {
    desired_size = 2
    max_size     = 3
    min_size     = 2
  }

  update_config {
    max_unavailable = 1
  }

  tags = {
    "k8s.io/cluster-autoscaler/${aws_eks_cluster.eks_cluster.name}" = "owned"
    "k8s.io/cluster-autoscaler/enabled"                             = true
  }

  depends_on = [
    aws_iam_role_policy_attachment.AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.AmazonEC2ContainerRegistryReadOnly,
  ]
}