#resource "aws_cloudformation_stack" "eks-network" {
 # name = "eks-network"

  #template_url = "https://amazon-eks.s3-us-west-2.amazonaws.com/cloudformation/2019-02-11/amazon-eks-vpc-sample.yaml"
#}
#output "securitygroupid" {
 # value = "${aws_security_group.SecurityGroups.id}"
#}  
#output "aws_cloudformation_stack_output" {
 # value = "${aws_cloudformation_stack.eks-network.outputs}"
#}
resource "aws_vpc" "imp_vpc"{
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "VPC"
  }
}
resource "aws_subnet" "first_subnet"{
  vpc_id = "${aws_vpc.imp_vpc.id}"
  availability_zone = "us-east-1a"
  cidr_block = "10.0.0.0/18"
  tags = {
    Name = "first_subnet"
  }
}
resource "aws_subnet" "second_subnet"{
  vpc_id = "${aws_vpc.imp_vpc.id}"
  availability_zone = "us-east-1b"
  cidr_block = "10.0.64.0/18"
  tags = {
    Name = "second_subnet"
  }
}
resource "aws_subnet" "third_subnet"{
  vpc_id = "${aws_vpc.imp_vpc.id}"
  availability_zone = "us-east-1c"
  cidr_block = "10.0.128.0/17"
  tags = {
    Name = "third_subnet" 
  }
}

resource "aws_internet_gateway" "eks_gateway"{
  vpc_id = "${aws_vpc.imp_vpc.id}"
  tags = {
    Name = "eks_gateway"
  }
}

resource "aws_route_table" "eks_route"{
  vpc_id = "${aws_vpc.imp_vpc.id}"
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.eks_gateway.id}"
  }
}
resource "aws_route_table_association" "a" {
  subnet_id      =  "${aws_subnet.first_subnet.id}"
  route_table_id = "${aws_route_table.eks_route.id}"
}
resource "aws_route_table_association" "b" {
  subnet_id      =  "${aws_subnet.second_subnet.id}"
  route_table_id = "${aws_route_table.eks_route.id}"
}
resource "aws_route_table_association" "c" {
  subnet_id      =  "${aws_subnet.third_subnet.id}"
  route_table_id = "${aws_route_table.eks_route.id}"
}
resource "aws_security_group" "eks_security_group" {
  name        = "eks_security__group"
  #description = "Allow TLS inbound traffic"
  vpc_id      = "${aws_vpc.imp_vpc.id}"
}
