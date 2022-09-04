# Gather available azs for us-east-1 and us-west-2
data "aws_availability_zones" "region_1" {

  state    = "available"
  provider = aws.region_1

}
data "aws_availability_zones" "region_2" {

  state    = "available"
  provider = aws.region_2

}