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