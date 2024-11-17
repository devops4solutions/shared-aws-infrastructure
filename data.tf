# Fetch all subnets in the VPC
data "aws_subnets" "selected" {
  filter {
    name   = "vpc-id"
    values = [var.vpc_id] # Replace with your VPC ID
  }
}

# Fetch subnet details to group by AZ
data "aws_subnet" "subnet_details" {
  for_each = toset(data.aws_subnets.selected.ids)
  id       = each.value
}

# Select one subnet per AZ
locals {
  subnets_per_az = distinct([
    for s in data.aws_subnet.subnet_details :
    { az = s.availability_zone, id = s.id }
  ])

  unique_subnet_ids = [
    for subnet in local.subnets_per_az :
    subnet.id
  ]
}