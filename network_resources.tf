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
# Create private subnets in us-east-1 and loop through available azs
resource "aws_subnet" "private_subnets" {

  count             = length(var.private_subnets_us-east-1)
  vpc_id            = module.vpc_us-east-1.vpc_id
  cidr_block        = element(var.private_subnets_us-east-1, count.index)
  availability_zone = element(data.aws_availability_zones.available.names, count.index)
  provider          = aws.us-east-1

  tags = {
    Name = "Private Subnet ${count.index}"
  }

}

