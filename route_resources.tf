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

  provider                  = aws.us-west-2
  vpc_peering_connection_id = aws_vpc_peering_connection.east-to-west.id
  auto_accept               = true

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


