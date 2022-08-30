terraform {

  backend "local" {}

}
provider "aws" {

  region  = "us-east-1"
  profile = "terraform_user"
  alias   = "us-east-1"

}
provider "aws" {

  region  = "us-west-2"
  profile = "terraform_user"
  alias   = "us-west-2"

}
# Gather available azs for us-east-1
data "aws_availability_zones" "available" {

  state    = "available"
  provider = aws.us-east-1

}
# Create VPC and Public Subnets in US East 1
module "vpc_us-east-1" {

  source         = "terraform-aws-modules/vpc/aws"
  cidr           = "10.0.0.0/16"
  azs            = [data.aws_availability_zones.available.names[0]]
  public_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
  tags = {
    Name = "us-east-1_VPC"
  }
  providers = {
    aws = aws.us-east-1
  }

}
# Create VPC and Public Subnet in US West 2
module "vpc_us-west-2" {

  source         = "terraform-aws-modules/vpc/aws"
  cidr           = "192.168.0.0/16"
  azs            = ["us-west-2a"]
  public_subnets = ["192.168.1.0/24"]
  tags = {
    Name = "us-west-2_VPC"
  }
  providers = {
    aws = aws.us-west-2
  }

}
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




# Outputs for VPC IDs
output "vpc_id_us-east-1" {

  value = module.vpc_us-east-1.vpc_id

}
output "vpc_id_us-west-2" {

  value = module.vpc_us-west-2.vpc_id

}

