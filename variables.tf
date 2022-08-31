variable "peer_region" {

  type    = string
  default = "us-west-2"

}
variable "private_subnets_us-east-1" {

  type        = list(string)
  description = "Private subnets to be built in us-east-1"
  default     = ["10.0.3.0/24", "10.0.4.0/24"]

}