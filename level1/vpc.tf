########## creating IG and NAT Gateway for VPC ##########
## Internet Gateway ## 
resource "aws_internet_gateway" "profiseeIG" {
    vpc_id = aws_vpc.profiseeVPC.id
    tags = {
      Name = "profisee-ig"
    }
}

## NAT Gateway ##
# Nat Gateway uses Elastic IP 
resource "aws_eip" "profiseeEIP" {
    tags = {
      Name = "profisee-eip"
    }
}
resource "aws_nat_gateway" "profiseeNAT" {
    allocation_id = aws_eip.profiseeEIP.id
    subnet_id = aws_subnet.publicSubnet.id
    tags = {
      Name = "profisee-nat-gateway"
    }
    depends_on = [ aws_internet_gateway.profiseeIG, aws_eip.profiseeEIP ]
}

########## creating VPC ##########
resource "aws_vpc" "profiseeVPC" {
    cidr_block = "10.224.0.0/16"
    enable_dns_hostnames = true
    enable_dns_support = true
    tags = {
        Name = "profisee-vpc"
    }
}

######### creating subnets for VPC ##########
## Public Subnet ##
resource "aws_subnet" "publicSubnet" {
    vpc_id = aws_vpc.profiseeVPC.id
    cidr_block = "10.224.1.0/24"
    availability_zone = "us-west-2a"
    tags = {
      Name = "public-subnet"
    }
}
## Private Subnet ##
resource "aws_subnet" "privateSubnet" {
    vpc_id = aws_vpc.profiseeVPC.id
    cidr_block = "10.224.2.0/24"
    availability_zone = "us-west-2a"
    tags = {
      Name = "private-subnet"
    }
}