terraform {

  backend "local" {}

}
provider "aws" {
  
  region  = "us-west-2"
  
  alias   = "us-west"

 }
provider "aws" {

  region = "ap-northeast-1"

  alias  = "tokyo"

 }
module "vpc" {

  source = "terraform-aws-modules/vpc/aws"

  cidr   = "10.200.0.0/16"

  providers = {
    name = "us-west" 
   }
}