# Outputs for VPC IDs
output "vpc_id_us-east-1" {

  value = module.vpc_us-east-1.vpc_id

}
output "vpc_id_us-west-2" {

  value = module.vpc_us-west-2.vpc_id

}
# Use the * to gather values from counted resources
output "private_subnet_ids" {

  value = resource.aws_subnet.private_subnets.*.id

}
output "public_subnet_id" {

  value = resource.aws_eip.nat-gw-eip

}