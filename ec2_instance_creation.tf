# Create test EC2 instance in each private subnet in region 1
resource "aws_instance" "private_ec2_region_1" {

  count                  = length(var.vpc_region1_private_subnets)
  ami                    = var.private_ec2_ami_region_1
  instance_type          = var.private_ec2_type
  availability_zone      = element(data.aws_availability_zones.region_1.names, count.index)
  subnet_id              = element(resource.aws_subnet.region_1_private_subnets.*.id, count.index)
  vpc_security_group_ids = [resource.aws_security_group.private_sg_region_1.id]
  provider               = aws.region_1
  tags = {
    Name = "EC2 in Private Subnet ${count.index} in ${var.region_1}"
  }

}
# Create test EC2 instance in each private subnet in region 2
resource "aws_instance" "private_ec2_region_2" {

  count                  = length(var.vpc_region2_private_subnets)
  ami                    = var.private_ec2_ami_region_2
  instance_type          = var.private_ec2_type
  availability_zone      = element(data.aws_availability_zones.region_2.names, count.index)
  subnet_id              = element(resource.aws_subnet.region_2_private_subnets.*.id, count.index)
  vpc_security_group_ids = [resource.aws_security_group.private_sg_region_2.id]
  provider               = aws.region_2
  tags = {
    Name = "EC2 in Private Subnet ${count.index} in ${var.region_2}"
  }

}
