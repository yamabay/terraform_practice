# Basic EC2 instance creation with Amazon Linux image
resource "aws_instance" "new_ec2s" {

  count             = length(var.private_subnets_us-east-1)
  ami               = "ami-05fa00d4c63e32376"
  instance_type     = "t2.micro"
  availability_zone = element(data.aws_availability_zones.us-east-1.names, count.index)
  provider          = aws.us-east-1
  subnet_id         = element(resource.aws_subnet.private_subnets.*.id, count.index)
  tags = {
    Name = "EC2 Private Subnet ${count.index}"
  }

}