# Gather available azs for us-east-1
data "aws_availability_zones" "available" {

  state    = "available"
  provider = aws.us-east-1

}