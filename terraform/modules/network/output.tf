#VPC
output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "vpc_arn" {
  value = aws_vpc.vpc.arn
}

output "main_rt_id" {
  value = aws_vpc.vpc.main_route_table_id
}

output "def_rt_id" {
  value = aws_vpc.vpc.default_route_table_id
}

output "def_nacl_id" {
  value = aws_vpc.vpc.default_network_acl_id
}

output "def_sg_id" {
  value = aws_vpc.vpc.default_security_group_id
}

output "vpc_cidr" {
  value = aws_vpc.vpc.cidr_block
}

output "vpc_tags" {
  value = aws_vpc.vpc.tags
}

#Internet Gateway
output "igw_id" {
  value = aws_internet_gateway.igw.id
}

output "igw_arn" {
  value = aws_internet_gateway.igw.arn
}

output "account_owner_id" {
  value = aws_internet_gateway.igw.owner_id
}

output "igw_tags" {
  value = aws_internet_gateway.igw.tags_all
}

#Subnet outputs
output "pub_sub_id" {
  value = aws_subnet.pub.*.id
}

output "pub_sub_id_list" {
  value = [aws_subnet.pub.*.id]
}

output "pub_sub_arn" {
  value = aws_subnet.pub.*.arn
}

output "priv_sub_id" {
  value = aws_subnet.priv.*.id
}

output "priv_sub_arn" {
  value = aws_subnet.priv.*.arn
}

output "pub_sub_az" {
  value = aws_subnet.pub.*.availability_zone
}

output "priv_sub_az" {
  value = aws_subnet.priv.*.availability_zone
}

output "pub_sub_cidr" {
  value = aws_subnet.pub.*.cidr_block
}

output "priv_sub_cidr" {
  value = aws_subnet.priv.*.cidr_block
}

output "pub_sub_vpc" {
  value = aws_subnet.pub.*.vpc_id
}

output "priv_sub_vpc" {
  value = aws_subnet.priv.*.vpc_id
}

output "pub_sub_tags" {
  value = aws_subnet.pub.*.tags
}

output "priv_sub_tags" {
  value = aws_subnet.priv.*.tags
}

output "subnets_from_data" {
  value = data.aws_subnets.pub.ids
}

#Eip/NAT
output "eip_id" {
  value = aws_eip.eip.*.id
}

output "eip_pub_ip" {
  value = aws_eip.eip.*.public_ip
}

output "eip_tags" {
  value = aws_eip.eip.*.tags_all
}

output "nat_id" {
  value = aws_nat_gateway.nat.*.id
}

output "nat_assoc_id" {
  value = aws_nat_gateway.nat.*.association_id
}

output "nat_ni_id" {
  value = aws_nat_gateway.nat.*.network_interface_id
}

output "nat_pub_ip" {
  value = aws_nat_gateway.nat.*.public_ip
}

output "nat_tags" {
  value = aws_nat_gateway.nat.*.tags_all
}

#Route table
output "rt_pub_id" {
  value = aws_route_table.for_pub_sub.id
}

output "rt_priv_id" {
  value = aws_route_table.for_priv_sub.*.id
}

output "rt_pub_arn" {
  value = aws_route_table.for_pub_sub.arn
}

output "rt_priv_arn" {
  value = aws_route_table.for_priv_sub.*.arn
}

output "rt_pub_tags" {
  value = aws_route_table.for_pub_sub.tags_all
}

output "rt_priv_tags" {
  value = aws_route_table.for_priv_sub.*.tags_all
}

