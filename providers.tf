terraform {

  backend "local" {}

}
provider "aws" {

  region  = var.region_1
  profile = var.profile
  alias   = "region_1"

}
provider "aws" {

  region  = var.region_2
  profile = var.profile
  alias   = "region_2"

}