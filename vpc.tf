# TODO narikawa 全体的何これ
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
# Subnet (public)
# ====================================================
resource "aws_subnet" "public_subnet_a" {
  vpc_id                  = aws_vpc.main.id
  availability_zone       = var.availability_zone["a"]
  cidr_block              = var.subnets_cidr["public_a"]
  map_public_ip_on_launch = true

  tags = {
    Name    = "${var.project}-${var.environment}-public-subnet-a"
    Project = var.project
    Env     = var.environment
    Type    = "public"
  }
}

resource "aws_subnet" "public_subnet_c" {
  vpc_id                  = aws_vpc.main.id
  availability_zone       = var.availability_zone["c"]
  cidr_block              = var.subnets_cidr["public_c"]
  map_public_ip_on_launch = true

  tags = {
    Name    = "${var.project}-${var.environment}-public-subnet-c"
    Project = var.project
    Env     = var.environment
    Type    = "public"
  }
}

# ====================================================
# Subnet (private)
# ====================================================
resource "aws_subnet" "private_subnet_a" {
  vpc_id                  = aws_vpc.main.id
  availability_zone       = var.availability_zone["a"]
  cidr_block              = var.subnets_cidr["private_a"]
  map_public_ip_on_launch = false

  tags = {
    Name    = "${var.project}-${var.environment}-private-subnet-a"
    Project = var.project
    Env     = var.environment
    Type    = "private"
  }
}

resource "aws_subnet" "private_subnet_c" {
  vpc_id                  = aws_vpc.main.id
  availability_zone       = var.availability_zone["c"]
  cidr_block              = var.subnets_cidr["private_c"]
  map_public_ip_on_launch = false

  tags = {
    Name    = "${var.project}-${var.environment}-private-subnet-c"
    Project = var.project
    Env     = var.environment
    Type    = "private"
  }
}
