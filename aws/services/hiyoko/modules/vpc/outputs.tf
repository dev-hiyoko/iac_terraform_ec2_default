output "id" {
  description = "The ID of the VPC"
  value       = aws_vpc.main.id
}

# Public Subnet IDs by Availability Zone
output "public_subnet_ids_by_az" {
  description = "Mapping of availability zones to public subnet IDs"
  value = {
    for i, az in var.public_subnets :
    az.availability_zone => aws_subnet.public[i].id
  }
}

# Private Subnet IDs by Availability Zone
output "private_subnet_ids_by_az" {
  description = "Mapping of availability zones to private subnet IDs"
  value = {
    for i, az in var.private_subnets :
    az.availability_zone => aws_subnet.private[i].id
  }
}
