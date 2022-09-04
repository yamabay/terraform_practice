# Outputs for VPC IDs
output "vpc_id_region_1" {

  description = "VPC ID created in region 1"
  value       = module.vpc_region_1.vpc_id

}
output "vpc_id_region_2" {

  description = "VPC ID created in region 2"
  value       = module.vpc_region_2.vpc_id

}
output "private_subnet_ids_region_1" {

  description = "Private Subnet IDs in region 1"
  value       = resource.aws_subnet.region_1_private_subnets.*.id

}
output "private_subnet_ids_region_2" {

  description = "Private Subnet IDs in region 2"
  value       = resource.aws_subnet.region_2_private_subnets.*.id

}
output "public_subnet_ids_region_1" {

  description = "Public Subnet IDs for region 1"
  value       = module.vpc_region_1.public_subnets

}
output "public_subnet_ids_region_2" {

  description = "Public Subnet IDs for region 2"
  value       = module.vpc_region_2.public_subnets

}
output "aws_eip_ids_region_1" {

  description = "EIP IDs that are associated with NAT GWs in region 1"
  value       = resource.aws_eip.nat_gw_eip_region_1.*.allocation_id

}
output "aws_eip_ids_region_2" {

  description = "EIP IDs that are associated with NAT GWs in region 2"
  value       = resource.aws_eip.nat_gw_eip_region_2.*.allocation_id

}