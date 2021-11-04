#Create VPC
data "aws_availability_zones" "zones" {}
resource "aws_vpc" "kharkov" {
  cidr_block = var.cidrblock_for_vpc
  tags = {
    Name = "${var.env}-VPC"
  }
}
#Create IGW for our VPC
resource "aws_internet_gateway" "myigw" {
  vpc_id = aws_vpc.kharkov.id
  depends_on = [aws_vpc.kharkov]
  tags = {
    Name = "${var.env}-IGW"
  }
}
#Create two public subnets
resource "aws_subnet" "publicsubnetA" {
  count = var.az_count
  cidr_block              = cidrsubnet(var.cidrblock_for_vpc,8,count.index + var.az_count)
  map_public_ip_on_launch = true
  vpc_id                  = aws_vpc.kharkov.id
  availability_zone       = data.aws_availability_zones.zones.names[count.index]
  tags = {
    Name = "${var.env}-publicA"
  }
}
#Create first private subnet
resource "aws_subnet" "privatesubnetA" {
  count = var.az_count
  cidr_block        = cidrsubnet(var.cidrblock_for_vpc,8,count.index + 4)
  vpc_id            = aws_vpc.kharkov.id
  availability_zone = data.aws_availability_zones.zones.names[count.index]
  tags = {
    Name = "${var.env}-privateA"
  }
}
resource "aws_route" "access" {
    route_table_id = aws_vpc.kharkov.main_route_table_id
    destination_cidr_block = var.destination
    gateway_id = aws_internet_gateway.myigw.id
}
resource "aws_route_table" "private" {
    count = var.az_count
    vpc_id = aws_vpc.kharkov.id
    depends_on = [aws_internet_gateway.myigw]
    route{
       cidr_block = var.destination
       nat_gateway_id = element(aws_nat_gateway.nat.*.id, count.index)
      }
    tags={
        Name = "${var.env}-route-for-public"
    }
}

resource "aws_nat_gateway" "nat" {
    count = var.az_count
    allocation_id = element(aws_eip.fornat.*.id, count.index)
    subnet_id = element(aws_subnet.publicsubnetA.*.id, count.index)
    tags={
      Name = "${var.env}-${count.index}-NATgateway"
    }
}

resource "aws_eip" "fornat" {
  count = var.az_count
  vpc = true
  depends_on = [aws_internet_gateway.myigw]
  tags={
    Name = "${var.env}-NatGateway"
  }
}

resource "aws_route_table_association" "private" {
  count = var.az_count
  route_table_id = element(aws_route_table.private.*.id, count.index)
  subnet_id = element(aws_subnet.privatesubnetA.*.id, count.index)
}
