# // Application Load Balancer
# resource "aws_lb" "alb" {
#   name               = "${var.environment}-${var.app_name}-ALB-${var.AWS_REGION}"
#   internal           = false
#   load_balancer_type = "application"
#   security_groups    = [aws_security_group.alb_sg.id]
#   subnets            = local.public_subnet_ids[*]

#   enable_deletion_protection = false

#   tags = merge(
#     var.additional_tags,
#     {
#        Name = "${var.environment}-${var.app_name}-ALB-${var.AWS_REGION}"
#        "kubernetes.io/cluster/${aws_eks_cluster.eks_cluster.name}"  = "owned"
#     },
#   )
# }

# #LB Listeners

# resource "aws_lb_target_group" "http" {
#   port     = 80
#   protocol = "HTTP"
#   vpc_id   = aws_vpc.main.id
# }

# resource "aws_lb_listener" "http_listener" {
#   load_balancer_arn = aws_lb.alb.arn
#   port              = "80"
#   protocol          = "HTTP"

#   default_action {
#     type             = "forward"
#     target_group_arn = aws_lb_target_group.http.arn
#   }
# }