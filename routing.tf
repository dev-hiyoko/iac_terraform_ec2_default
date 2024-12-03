resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name    = "${var.project}-${var.environment}-public-rt"
    Project = var.project
    Env     = var.environment
    Type    = "public"
  }
}

resource "aws_route_table_association" "public_rt_a" {
  route_table_id = aws_route_table.public_rt.id
  subnet_id      = aws_subnet.public_subnet_a.id
}

resource "aws_route_table_association" "public_rt_c" {
  route_table_id = aws_route_table.public_rt.id
  subnet_id      = aws_subnet.public_subnet_c.id
}

resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name    = "${var.project}-${var.environment}-private-rt"
    Project = var.project
    Env     = var.environment
    Type    = "private"
  }
}

resource "aws_route_table_association" "private_rt_a" {
  route_table_id = aws_route_table.private_rt.id
  subnet_id      = aws_subnet.private_subnet_a.id
}

resource "aws_route_table_association" "private_rt_c" {
  route_table_id = aws_route_table.private_rt.id
  subnet_id      = aws_subnet.private_subnet_c.id
}