# Create Peering Connection between VPCs
resource "aws_vpc_peering_connection" "east-to-west" {

  provider      = aws.us-east-1
  peer_owner_id = module.vpc_us-west-2.vpc_owner_id
  peer_vpc_id   = module.vpc_us-west-2.vpc_id
  vpc_id        = module.vpc_us-east-1.vpc_id
  peer_region   = var.peer_region
  tags = {
    Name = "east-to-west-peering"
  }

}
# Approval for Peering Connection
resource "aws_vpc_peering_connection_accepter" "peer" {

  vpc_peering_connection_id = aws_vpc_peering_connection.east-to-west.id
  auto_accept               = true
  provider                  = aws.us-west-2

}
# Update route tables in both VPCs with peering connection route to each other
resource "aws_route" "east_to_peer" {


  route_table_id            = module.vpc_us-east-1.public_route_table_ids[0]
  destination_cidr_block    = "192.168.0.0/16"
  vpc_peering_connection_id = aws_vpc_peering_connection.east-to-west.id
  provider                  = aws.us-east-1

}
resource "aws_route" "west_to_peer" {

  route_table_id            = module.vpc_us-west-2.public_route_table_ids[0]
  destination_cidr_block    = "10.0.0.0/16"
  vpc_peering_connection_id = aws_vpc_peering_connection.east-to-west.id
  provider                  = aws.us-west-2

}
# Create new route table for private subnets in us-east-1
resource "aws_route_table" "private_rt" {

  count    = length(var.private_subnets_us-east-1)
  vpc_id   = module.vpc_us-east-1.vpc_id
  provider = aws.us-east-1
  tags = {
    Name = "Private rt ${count.index} for us-east-1 subnets"
  }

}
# Associate new route tables with private subnets in us-east-1
resource "aws_route_table_association" "us-east-1_private" {

  count          = length(var.private_subnets_us-east-1)
  subnet_id      = element(resource.aws_subnet.private_subnets.*.id, count.index)
  route_table_id = element(resource.aws_route_table.private_rt.*.id, count.index)
  provider       = aws.us-east-1

}
# Create the default route pointing to nat gateway for private subnets
# Could have used the count argument, but wanted to practice calling specific indices
resource "aws_route" "default-to-nat0" {

  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = resource.aws_nat_gateway.nat-gws[0].id
  route_table_id         = resource.aws_route_table.private_rt[0].id
  provider               = aws.us-east-1

}
resource "aws_route" "default-to-nat1" {

  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = resource.aws_nat_gateway.nat-gws[1].id
  route_table_id         = resource.aws_route_table.private_rt[1].id
  provider               = aws.us-east-1

}