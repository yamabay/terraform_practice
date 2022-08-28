terraform {

  backend "local" {}

}
provider "aws" {
 
  region  = "us-west-2"
  alias   = "us-west-2"

 }
provider "aws" {

  region = "us-east-1"
  alias  = "us-east-1"

 }

module "vpc" {

  source = "terraform-aws-modules/vpc/aws"
  cidr   = "192.168.1.0/16"
  azs    =  "us-west-2a"
  public_subnets = ["192.168.1.0/24"]

  providers = {
    aws = aws.us-west-2 
   }
  output "vpc_id" {
    value = aws
  }
}
#module "vpc" {
#  
#  source = "terraform-aws-modules/vpc/aws"
#  cidr   = "10.0.0.0/16"
#  azs    = "us-east-1a"
#  public_subnets = ["10.0.2.0/24", "10.0.1.0/24"]
#
#  providers = {
#    aws = aws.us-east-1
#  }
#}