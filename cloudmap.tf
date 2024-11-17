resource "aws_service_discovery_private_dns_namespace" "cloudmap" {
  name = var.cloudmap_name
  vpc  = var.vpc_id
}
