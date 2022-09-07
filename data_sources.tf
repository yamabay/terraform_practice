# Gather available azs for both regions
data "aws_availability_zones" "region_1" {

  state    = "available"
  provider = aws.region_1

}
data "aws_availability_zones" "region_2" {

  state    = "available"
  provider = aws.region_2

}
# Gather most recent AMI for amazon linux image in each region
data "aws_ami" "amazon_linux_region_1" {

  most_recent = true
  owners = ["amazon"]
  provider = aws.region_1
  # Example of using filter, will return amazon linux image with arm64 architecture
  # Can add more filters by repeating the filter option, name should reference the key you want to filter against
  filter {
    name = "architecture"
    values = [
      "x86_64"
    ]
  }

}
data "aws_ami" "amazon_linux_region_2" {

  most_recent = true
  owners = ["amazon"]
  provider = aws.region_2
  filter {
    name = "architecture"
    values = [
      "x86_64"
    ]
  }

}