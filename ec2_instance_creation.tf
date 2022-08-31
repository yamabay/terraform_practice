# Basic EC2 instance creation with Amazon Linux image
resource "aws_instance" "new_ec2" {

  ami               = "ami-05fa00d4c63e32376"
  instance_type   = "t2.micro"
  availability_zone = "us-east-1a"
  #host_recovery     = "on"
  #auto_placement    = "on"
  provider          = aws.us-east-1
  tags = {
    Name = "Test EC2 Instance"
  }

}