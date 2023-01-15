locals {
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets = ["10.0.3.0/24", "10.0.4.0/24"]
  public_subnet_ids = [aws_subnet.public01.id, aws_subnet.public02.id]
  az = ["us-east-1a", "us-east-1b"]

}