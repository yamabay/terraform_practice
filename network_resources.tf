# Create VPC and Public Subnets in region 1
module "vpc_region_1" {

  source         = "terraform-aws-modules/vpc/aws"
  cidr           = var.vpc_region1_cidr
  azs            = data.aws_availability_zones.region_1.names
  public_subnets = var.vpc_region1_public_subnets
  tags = {
    Name = "VPC in ${var.region_1}"
  }
  providers = {
    aws = aws.region_1
  }

}
# Create VPC and Public Subnet in region 2
module "vpc_region_2" {

  source         = "terraform-aws-modules/vpc/aws"
  cidr           = var.vpc_region2_cidr
  azs            = data.aws_availability_zones.region_2.names
  public_subnets = var.vpc_region2_public_subnets
  tags = {
    Name = "VPC in ${var.region_2}"
  }
  providers = {
    aws = aws.region_2
  }

}
# Create private subnets in region 1 and loop through available azs
resource "aws_subnet" "region_1_private_subnets" {

  count             = length(var.vpc_region1_private_subnets)
  vpc_id            = module.vpc_region_1.vpc_id
  cidr_block        = element(var.vpc_region1_private_subnets, count.index)
  availability_zone = element(data.aws_availability_zones.region_1.names, count.index)
  provider          = aws.region_1

  tags = {
    Name = "Private Subnet ${count.index} in ${var.region_1}"
  }

}
# Create private subnets in region 2 and loop through available azs
resource "aws_subnet" "region_2_private_subnets" {

  count             = length(var.vpc_region2_private_subnets)
  vpc_id            = module.vpc_region_2.vpc_id
  cidr_block        = element(var.vpc_region2_private_subnets, count.index)
  availability_zone = element(data.aws_availability_zones.region_2.names, count.index)
  provider          = aws.region_2

  tags = {
    Name = "Private Subnet ${count.index} in ${var.region_2}"
  }

}
# Create EIPs for NAT GWs in region 1
resource "aws_eip" "nat_gw_eip_region_1" {

  count    = length(module.vpc_region_1.public_subnets)
  vpc      = true
  provider = aws.region_1
  tags = {
    Name = "EIPs for NAT GW in ${var.region_1}"
  }

}
# Create EIPs for NAT GWs in region 2
resource "aws_eip" "nat_gw_eip_region_2" {

  count    = length(module.vpc_region_2.public_subnets)
  vpc      = true
  provider = aws.region_2
  tags = {
    Name = "EIPs for NAT GW in ${var.region_2}"
  }

}
# Create NAT GWs and assign to public subnets in region 1
resource "aws_nat_gateway" "nat_gws_region_1" {

  count         = length(module.vpc_region_1.public_subnets)
  allocation_id = element(aws_eip.nat_gw_eip_region_1.*.allocation_id, count.index)
  subnet_id     = element(module.vpc_region_1.public_subnets, count.index)
  provider      = aws.region_1
  tags = {
    Name = "NAT GW ${count.index} in ${var.region_1}"
  }

}
# Create NAT GWs and assign to public subnets in region 2
resource "aws_nat_gateway" "nat_gws_region_2" {

  count         = length(module.vpc_region_2.public_subnets)
  allocation_id = element(aws_eip.nat_gw_eip_region_2.*.allocation_id, count.index)
  subnet_id     = element(module.vpc_region_2.public_subnets, count.index)
  provider      = aws.region_2
  tags = {
    Name = "NAT GW ${count.index} in ${var.region_2}"
  }

}