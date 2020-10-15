# vpc.tf
# Create VPC/Subnet/Security Group/Network ACL

provider "aws" {
  version = "~> 2.0"
  profile = "${var.profile}"
  shared_credentials_file = "~/.aws/credentials"
  region = "${var.region}"
}


# create the VPC
resource "aws_vpc" "My_VPC" {
  cidr_block           = var.vpcCIDRblock
  enable_dns_hostnames = "true"
  enable_dns_support   = "true"
tags = {
    Name = "${var.vpcName}"
}
}
# end resource

# create the Subnet

resource "aws_subnet" "My_VPC_Subnet1" {
  vpc_id                  = "${aws_vpc.My_VPC.id}"
  cidr_block              = var.subnetCIDRblock1
  availability_zone       = "us-east-1a"
tags = {
   Name = "${var.vpcName}-1"
}
}

resource "aws_subnet" "My_VPC_Subnet2" {
  vpc_id                  = "${aws_vpc.My_VPC.id}"
  cidr_block              = var.subnetCIDRblock2
  availability_zone       = "us-east-1b"
tags = {
   Name = "${var.vpcName}-2"
}
}

resource "aws_subnet" "My_VPC_Subnet3" {
  vpc_id                  = "${aws_vpc.My_VPC.id}"
  cidr_block              = var.subnetCIDRblock3
  availability_zone       = "us-east-1c"
tags = {
   Name = "${var.vpcName}-3"
}
}
# end resource


# Create the Internet Gateway
resource "aws_internet_gateway" "My_VPC_GW" {
 vpc_id = "${aws_vpc.My_VPC.id}"
 tags = {
        Name = "${var.vpcName}-Internet Gateway"
}
}
# end resource

# Create the Route Table
resource "aws_route_table" "My_VPC_route_table" {
 vpc_id = "${aws_vpc.My_VPC.id}"
 tags = {
        Name = "${var.vpcName}-Route Table"
}
}
# end resource

# Create the Internet Access
resource "aws_route" "My_VPC_internet_access" {
  route_table_id         = "${aws_route_table.My_VPC_route_table.id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = "${aws_internet_gateway.My_VPC_GW.id}"
}
# end resource


# Associate the Route Table with the Subnet
resource "aws_route_table_association" "My_VPC_association1" {
  subnet_id      = "${aws_subnet.My_VPC_Subnet1.id}"
  route_table_id = "${aws_route_table.My_VPC_route_table.id}"
} # end resource

# Associate the Route Table with the Subnet
resource "aws_route_table_association" "My_VPC_association2" {
  subnet_id      = "${aws_subnet.My_VPC_Subnet2.id}"
  route_table_id = "${aws_route_table.My_VPC_route_table.id}"
} # end resource

# Associate the Route Table with the Subnet
resource "aws_route_table_association" "My_VPC_association3" {
  subnet_id      = "${aws_subnet.My_VPC_Subnet3.id}"
  route_table_id = "${aws_route_table.My_VPC_route_table.id}"
} # end resource

# end vpc.tf