# Create SG for Public Subnet instances that will only allow SSH
### NEED TO SET VPC ID FOR ALL SGs
resource "aws_security_group" "public_sg_east" {

  name        = "public-sg-us-east-1"
  description = "Security Group for Public Subnet EC2 instances"
  provider    = aws.us-east-1
  ingress {

    description = "Allow inbound SSH only"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }

}
resource "aws_security_group" "public_sg_west" {

  name        = "public-sg-us-west-2"
  description = "Security Group for Public Subnet EC2 instances"
  provider    = aws.us-west-2
  ingress {

    description = "Allow inbound SSH only"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }

}
# Create SG for Private Subnet instances that will only allow SSH from public_sg SGs
resource "aws_security_group" "private_sg_east" {

  name        = "private-sg-east"
  description = "Security Group for Private Subnet EC2 instances in us-east-1"
  provider    = aws.us-east-1
  ingress {

    description     = "Allow inbound SSH from public-sg"
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [resource.aws_security_group.public_sg_east.id, resource.aws_security_group.public_sg_west.id]

  }

}
resource "aws_security_group" "private_sg_west" {

  name        = "private-sg-west"
  description = "Security Group for Private Subnet EC2 instances in us-west-2"
  provider    = aws.us-west-2
  ingress {

    description     = "Allow inbound SSH from public-sg"
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [resource.aws_security_group.public_sg_east.id, resource.aws_security_group.public_sg_west.id]

  }

}