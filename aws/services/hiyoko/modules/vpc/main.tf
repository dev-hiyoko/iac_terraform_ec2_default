# ====================================================
# VPC
# ====================================================
resource "aws_vpc" "main" {
  cidr_block                       = var.vpc_cidr
  instance_tenancy                 = "default"
  enable_dns_support               = true
  enable_dns_hostnames             = true
  assign_generated_ipv6_cidr_block = false

  tags = {
    Name    = "${var.project}-${var.environment}-vpc-main"
    Project = var.project
    Env     = var.environment
  }
}

# ====================================================
# Public Subnets
# ====================================================
resource "aws_subnet" "public" {
  count                   = length(var.public_subnets)
  vpc_id                  = aws_vpc.main.id
  availability_zone       = var.public_subnets[count.index]["availability_zone"]
  cidr_block              = var.public_subnets[count.index]["cidr"]
  map_public_ip_on_launch = true

  tags = {
    Name     = "${var.project}-${var.environment}-public-subnet-${count.index}"
    Project = var.project
    Env     = var.environment
    Type    = "public"
  }
}

# ====================================================
# Private Subnets
# ====================================================
resource "aws_subnet" "private" {
  count                   = length(var.private_subnets)
  vpc_id                  = aws_vpc.main.id
  availability_zone       = var.private_subnets[count.index]["availability_zone"]
  cidr_block              = var.private_subnets[count.index]["cidr"]
  map_public_ip_on_launch = false

  tags = {
    Name    = "${var.project}-${var.environment}-private-subnet-${count.index}"
    Project = var.project
    Env     = var.environment
    Type    = "private"
  }
}

