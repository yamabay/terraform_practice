# Outputs for VPC IDs
output "vpc_id_us-east-1" {

  description = "VPC ID created in us-east-1"
  value = module.vpc_us-east-1.vpc_id

}
output "vpc_id_us-west-2" {

  description = "VPC ID created in us-west-2"
  value = module.vpc_us-west-2.vpc_id

}
# Use the * to gather values from counted resources
output "private_subnet_ids" {

  description = "Private Subnet IDs in us-east-1"
  value = resource.aws_subnet.private_subnets.*.id

}
output "public_subnet_ids_us-east-1" {

  description = "Public Subnet IDs for us-east-1"
  value = module.vpc_us-east-1.public_subnets

}
output "public_subnet_ids_us-west-2" {

  description = "Public Subnet IDs for us-west-2"
  value = module.vpc_us-west-2.public_subnets

}
output "aws_eip_ids" {

  description = "EIP IDs that are associated with NAT GWs"
  value = resource.aws_eip.nat-gw-eip.*.allocation_id

}