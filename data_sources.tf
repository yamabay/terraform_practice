# Gather available azs for us-east-1 and us-west-2
data "aws_availability_zones" "us-east-1" {

  state    = "available"
  provider = aws.us-east-1

}
data "aws_availability_zones" "us-west-2" {

  state    = "available"
  provider = aws.us-west-2

}