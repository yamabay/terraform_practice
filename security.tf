# Create SG for Public Subnet instances that will only allow SSH
### NEED TO SET VPC ID FOR ALL SGs
resource "aws_security_group" "public_sg_region_1" {

  name        = "public_sg_${var.region_1}"
  description = "Security Group for Public EC2 in ${var.region_1}"
  vpc_id      = module.vpc_region_1.vpc_id
  provider    = aws.region_1
  ingress {

    description = "Allow inbound SSH only"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }

}
resource "aws_security_group" "public_sg_region_2" {

  name        = "public_sg_${var.region_2}"
  description = "Security Group for Public EC2 in ${var.region_2}"
  vpc_id      = module.vpc_region_2.vpc_id
  provider    = aws.region_2
  ingress {

    description = "Allow inbound SSH only"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }

}
# Create SG for Private Subnet instances that will only allow SSH from public_sg SGs in region 1
resource "aws_security_group" "private_sg_region_1" {

  name        = "private_sg_${var.region_1}"
  description = "Security Group for Private EC2 in ${var.region_1}"
  vpc_id      = module.vpc_region_1.vpc_id
  provider    = aws.region_1
  ingress {

    description     = "Allow inbound SSH from public-sg"
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [resource.aws_security_group.public_sg_region_1.id]

  }

}
# Create SG for Private Subnet instances that will only allow SSH from public_sg SGs in region 2
resource "aws_security_group" "private_sg_region_2" {

  name        = "private_sg_${var.region_2}"
  description = "Security Group for Private EC2 in ${var.region_2}"
  vpc_id      = module.vpc_region_2.vpc_id
  provider    = aws.region_2
  ingress {

    description     = "Allow inbound SSH from public-sg"
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [resource.aws_security_group.public_sg_region_2.id]

  }

}