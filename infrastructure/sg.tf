# // ALB Security Group
# resource "aws_security_group" "alb_sg" {
#   name        = "${var.environment}-${var.app_name}-alb-SG-${var.AWS_REGION}"
#   description = "Application load balancer security group"
#   vpc_id      = aws_vpc.main.id

#   egress {
#       from_port   = 0
#       to_port     = 0
#       protocol    = "-1"
#       cidr_blocks = ["0.0.0.0/0"]
#   }

#   tags = merge(
#     var.additional_tags,
#     {
#        Name                                                         = "${var.environment}-${var.app_name}-alb-SG-${var.AWS_REGION}"
#        "kubernetes.io/cluster/${aws_eks_cluster.eks_cluster.name}"  = "owned"
#     },
#   )
# }

# // Ingress rules
# resource "aws_security_group_rule" "http_ingress" {
#   cidr_blocks              = ["0.0.0.0/0"]
#   description              = "Allow http communication"
#   from_port                = 80
#   to_port                  = 80
#   protocol                 = "tcp"
#   security_group_id        = aws_security_group.alb_sg.id
#   type                     = "ingress"
# }

# resource "aws_security_group_rule" "ssh" {
#   cidr_blocks              = ["0.0.0.0/0"]
#   description              = "Allow http communication"
#   from_port                = 22
#   to_port                  = 22
#   protocol                 = "tcp"
#   security_group_id        = aws_security_group.alb_sg.id
#   type                     = "ingress"
# }