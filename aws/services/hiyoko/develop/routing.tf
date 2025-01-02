# ====================================================
# Route Table (public)
# ====================================================
resource "aws_route_table" "public_rt" {
  vpc_id = module.vpc_main.id

  tags = {
    Name    = "${var.project}-${var.environment}-public-rt"
    Project = var.project
    Env     = var.environment
    Type    = "public"
  }
}

resource "aws_route_table_association" "public_rt_a" {
  route_table_id = aws_route_table.public_rt.id
  subnet_id      = module.vpc_main.public_subnet_ids_by_az[var.availability_zone["a"]]
}

resource "aws_route_table_association" "public_rt_c" {
  route_table_id = aws_route_table.public_rt.id
  subnet_id      = module.vpc_main.public_subnet_ids_by_az[var.availability_zone["c"]]
}

# ====================================================
# Route Table (private)
# ====================================================
resource "aws_route_table" "private_rt" {
  vpc_id = module.vpc_main.id

  tags = {
    Name    = "${var.project}-${var.environment}-private-rt"
    Project = var.project
    Env     = var.environment
    Type    = "private"
  }
}

resource "aws_route_table_association" "private_rt_a" {
  route_table_id = aws_route_table.private_rt.id
  subnet_id      = module.vpc_main.private_subnet_ids_by_az[var.availability_zone["a"]]
}

resource "aws_route_table_association" "private_rt_c" {
  route_table_id  = aws_route_table.private_rt.id
  subnet_id      = module.vpc_main.private_subnet_ids_by_az[var.availability_zone["c"]]
}

# ====================================================
# Internet Gateway
# ====================================================
resource "aws_internet_gateway" "main" {
  vpc_id = module.vpc_main.id

  tags = {
    Name    = "${var.project}-${var.environment}-igw-main"
    Project = var.project
    Env     = var.environment
  }
}

# ====================================================
# Route
# ====================================================
resource "aws_route" "public_igw_main" {
  route_table_id         = aws_route_table.public_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.main.id
  depends_on             = [aws_route_table.public_rt]
}
