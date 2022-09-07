
#### GLOBAL VARIABLES ####

variable "profile" {

  type        = string
  description = "Profile used for AWS authentication"
  default     = "terraform_user"

}
variable "ec2_type" {

  type        = string
  description = "Set instance type for ec2 in private subnets"
  default     = "t2.micro"

}

#### REGION 1 VARIABLES ####

variable "region_1" {

  type        = string
  description = "Set region 1 here"
  default     = "us-east-1"

}
variable "vpc_region1_cidr" {

  type        = string
  description = "CIDR for region 1"
  default     = "10.0.0.0/16"

}
variable "vpc_region1_public_subnets" {

  type        = list(string)
  description = "Public Subnets for region 1"
  default     = ["10.0.1.0/24", "10.0.2.0/24"]

}
variable "vpc_region1_private_subnets" {

  type        = list(string)
  description = "Private Subnets for region 1"
  default     = ["10.0.3.0/24", "10.0.4.0/24"]

}
#variable "ec2_ami_region_1" {
#
#  type        = string
#  description = "Set AMI for image for ec2 image deployed in private subnets in region 1"
#  default     = "ami-05fa00d4c63e32376"
#
#}

#### REGION 2 VARIABLES ####

variable "region_2" {

  type        = string
  description = "Set region 2 here"
  default     = "us-west-2"

}
variable "vpc_region2_cidr" {

  type        = string
  description = "CIDR for region 1"
  default     = "192.168.0.0/16"

}
variable "vpc_region2_public_subnets" {

  type        = list(string)
  description = "Public Subnets for region 2"
  default     = ["192.168.1.0/24", "192.168.2.0/24"]

}
variable "vpc_region2_private_subnets" {

  type        = list(string)
  description = "Private Subnets for region 2"
  default     = ["192.168.3.0/24", "192.168.4.0/24"]

}
#variable "ec2_ami_region_2" {
#
#  type        = string
#  description = "Set AMI for image for ec2 image deployed in private subnets in region 2"
#  default     = "ami-0c2ab3b8efb09f272"
#
#}