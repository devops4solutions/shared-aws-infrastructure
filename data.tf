# Fetch all subnets in the VPC
data "aws_subnets" "selected" {
  filter {
    name   = "vpc-id"
    values = [var.vpc_id] # Replace with your VPC ID
  }
}