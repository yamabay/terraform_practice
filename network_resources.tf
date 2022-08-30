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
# Gather available azs
data "aws_availability_zones" "available" {

  state    = "available"
  provider = aws.us-east-1

}
# Outputs for VPC IDs
output "vpc_id_us-east-1" {

  value = module.vpc_us-east-1.vpc_id

}
output "vpc_id_us-west-2" {

  value = module.vpc_us-west-2.vpc_id
  
}


