terraform {
provider "aws" {
  source  = "hashicorp/aws"
  region  = "us-west-2"
  alias   = "us-west-2"
 }
provider "aws" {
  source  = "hashicorp/aws"
  region = "ap-northeast-1"
  alias  = "tokyo"
 }
}