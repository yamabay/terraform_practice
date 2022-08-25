terraform {

  backend "local" {}

}
provider "aws" {

  source  = "terraform-aws-modules/vpc/aws"
  
  region  = "us-west-2"
  
  alias   = "us-west"

 }
provider "aws" {

  source  = "terraform-aws-modules/vpc/aws"

  region = "ap-northeast-1"

  alias  = "tokyo"

 }