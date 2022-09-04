# Create Peering Connection between VPCs
resource "aws_vpc_peering_connection" "vpc_peering" {

  provider      = aws.region_1
  peer_owner_id = module.vpc_region_2.vpc_owner_id
  peer_vpc_id   = module.vpc_region_2.vpc_id
  vpc_id        = module.vpc_region_1.vpc_id
  peer_region   = var.region_2
  tags = {
    Name = "Peering Connection between ${var.region_1} and ${var.region_2}"
  }

}
# Approval for Peering Connection
resource "aws_vpc_peering_connection_accepter" "peer" {

  vpc_peering_connection_id = aws_vpc_peering_connection.vpc_peering.id
  auto_accept               = true
  provider                  = aws.region_2

}
# Update route tables in both VPCs with peering connection route to each other
resource "aws_route" "region_1_to_peer" {


  route_table_id            = module.vpc_region_1.public_route_table_ids[0]
  destination_cidr_block    = var.vpc_region2_cidr
  vpc_peering_connection_id = aws_vpc_peering_connection.vpc_peering.id
  provider                  = aws.region_1

}
resource "aws_route" "region_2_to_peer" {

  route_table_id            = module.vpc_region_2.public_route_table_ids[0]
  destination_cidr_block    = var.vpc_region1_cidr
  vpc_peering_connection_id = aws_vpc_peering_connection.vpc_peering.id
  provider                  = aws.region_2

}
# Create new route table for private subnets in region 1
resource "aws_route_table" "private_rt_region_1" {

  count    = length(var.vpc_region1_private_subnets)
  vpc_id   = module.vpc_region_1.vpc_id
  provider = aws.region_1
  tags = {
    Name = "Private rt ${count.index} for ${var.region_1} subnets"
  }

}
# Create new route table for private subnets in region 2
resource "aws_route_table" "private_rt_region_2" {

  count    = length(var.vpc_region2_private_subnets)
  vpc_id   = module.vpc_region_2.vpc_id
  provider = aws.region_2
  tags = {
    Name = "Private rt ${count.index} for ${var.region_2} subnets"
  }

}
# Associate new route tables with private subnets in region 1
resource "aws_route_table_association" "private_rt_assoc_region_1" {

  count          = length(var.vpc_region1_private_subnets)
  subnet_id      = element(resource.aws_subnet.region_1_private_subnets.*.id, count.index)
  route_table_id = element(resource.aws_route_table.private_rt_region_1.*.id, count.index)
  provider       = aws.region_1

}
# Associate new route tables with private subnets in region 2
resource "aws_route_table_association" "private_rt_assoc_region_2" {

  count          = length(var.vpc_region2_private_subnets)
  subnet_id      = element(resource.aws_subnet.region_2_private_subnets.*.id, count.index)
  route_table_id = element(resource.aws_route_table.private_rt_region_2.*.id, count.index)
  provider       = aws.region_2

}
# Create the default route pointing to NAT GWs for private subnets in region 1
resource "aws_route" "default_nat_gw_region_1" {

  count                  = length(resource.aws_nat_gateway.nat_gws_region_1)
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = element(resource.aws_nat_gateway.nat_gws_region_1.*.id, count.index)
  route_table_id         = element(resource.aws_route_table.private_rt_region_1.*.id, count.index)
  provider               = aws.region_1

}
# Create the default route pointing to NAT GWs for private subnets in region 2
resource "aws_route" "default_nat_gw_region_2" {

  count                  = length(resource.aws_nat_gateway.nat_gws_region_2)
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = element(resource.aws_nat_gateway.nat_gws_region_2.*.id, count.index)
  route_table_id         = element(resource.aws_route_table.private_rt_region_2.*.id, count.index)
  provider               = aws.region_2

}