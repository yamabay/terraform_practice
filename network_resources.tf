terraform {

  backend "local" {}

}
provider "aws" {

  region  = "us-west-2"
  profile = "terraform_user"

}

module "vpc" {
  source         = "terraform-aws-modules/vpc/aws"
  cidr           = "192.168.0.0/16"
  azs            = ["us-west-2a"]
  public_subnets = ["192.168.1.0/24"]
  tags = {
    Name = "Uchi_VPC"
  }
}
data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_subnet" "test_subnet_1" {
  vpc_id            = module.vpc.vpc_id
  cidr_block        = "192.168.2.0/24"
  availability_zone = data.aws_availability_zones.available.names[0]
  tags = {
    Name = "test_subnet_1"
  }
}