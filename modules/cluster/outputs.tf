output "Current_region"{
  value = var.region
}
output "Vpc_cidr-block"{
  value = aws_vpc.kharkov.cidr_block
}
output "InternetGateway4" {
  value = aws_internet_gateway.myigw.id
}
output "Static_IP_forNAT"{
  value = aws_eip.fornat.*.public_ip
}
output "id_of_igw"{
  value = aws_internet_gateway.myigw.id
}
output "main_table"{
  value = aws_vpc.kharkov.main_route_table_id
}
output "nat_gateway_ids"{
  values = aws_nat_gateway.nat.*.id
}
output "private_subnet_ids"{
  value = aws_subnet.privatesubnetA.*.id
}
output "public_subnet_ids"{
  value = aws_subnet.publicsubnetA.*.id
}
output "aviability_zones"{
  value = data.aws_availability_zones.zones.names
}
