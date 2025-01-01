# VPC Configuration
resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr_block
  tags = merge(var.tags, {
    Name = var.vpc_name
  })
}

# VPC default security group
resource "aws_security_group" "default" {
  vpc_id = aws_vpc.main.id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = []
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = []
  }

  tags = merge(var.tags, {
    Name = "${var.vpc_name}-default-sg"
  })
}

#Subnet Configuration
data "aws_availability_zones" "available" {
  state = "available"
}

# Private Subnets
resource "aws_subnet" "private" {
  for_each   = toset(data.aws_availability_zones.available.names)

  vpc_id            = aws_vpc.main.id
  cidr_block        = cidrsubnet(var.vpc_cidr_block, 8, index(data.aws_availability_zones.available.names, each.key))
  availability_zone = each.key

  tags = merge(var.tags, {
    Name = "private-subnet-${each.key}"
  })
}

# Public Subnets
resource "aws_subnet" "public" {
  for_each = toset(data.aws_availability_zones.available.names)

  vpc_id            = aws_vpc.main.id
  cidr_block        = cidrsubnet(var.vpc_cidr_block, 8, index(data.aws_availability_zones.available.names, each.key) + 8) # Offset by a fixed value
  availability_zone = each.key

  map_public_ip_on_launch = true

  tags = merge(var.tags, {
    Name = "public-subnet-${each.key}"
  })
}

# Internet Gateway
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = merge(var.tags, {
    Name = "${var.vpc_name}-igw"
  })
}

# Route Table for Public Subnets
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = merge(var.tags, {
    Name = "${var.vpc_name}-public-rt"
  })
}

resource "aws_route_table_association" "public" {
  for_each = aws_subnet.public

  subnet_id      = each.value.id
  route_table_id = aws_route_table.public.id
}

# Route Table for Private Subnets
resource "aws_route_table" "private" {
  for_each = aws_subnet.private

  vpc_id = aws_vpc.main.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.main.id
  }
  
  depends_on = [aws_nat_gateway.main]

  tags = merge(var.tags, {
    Name = "${var.vpc_name}-private-rt-${each.key}"
  })
}

# Associate Private Route Table with Private Subnets
resource "aws_route_table_association" "private" {
  for_each = aws_subnet.private

  subnet_id      = each.value.id
  route_table_id = aws_route_table.private[each.key].id
}


# Security Group Configuration
resource "aws_security_group" "lambda" {
  name_prefix = "lambda-sg"
  vpc_id      = aws_vpc.main.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [aws_vpc.main.cidr_block]
  }
}

# NAT Gateway
resource "aws_nat_gateway" "main" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public[data.aws_availability_zones.available.names[0]].id

  tags = merge(var.tags, {
    Name = "${var.vpc_name}-nat-gw"
  })
}

# Elastic IP for NAT Gateway
resource "aws_eip" "nat" {
  tags = merge(var.tags, {
    Name = "${var.vpc_name}-nat-eip-primary"
  })
}

# NACL for Private Subnets
resource "aws_network_acl" "private" {
  vpc_id = aws_vpc.main.id

  tags = merge(var.tags, {
    Name = "${var.vpc_name}-private-nacl"
  })
}

# Inbound Rules for Private Subnets (Internal Communications Only)
resource "aws_network_acl_rule" "private_inbound_internal" {
  network_acl_id = aws_network_acl.private.id
  rule_number    = 100
  protocol       = "-1"
  rule_action    = "allow"
  cidr_block     = aws_vpc.main.cidr_block
  egress         = false
}

# Outbound Rules for Private Subnets
resource "aws_network_acl_rule" "private_outbound_all" {
  network_acl_id = aws_network_acl.private.id
  rule_number    = 100
  protocol       = "-1"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  egress         = true
}

# Associate Private NACL with Private Subnets
resource "aws_network_acl_association" "private" {
  for_each      = aws_subnet.private
  subnet_id     = each.value.id
  network_acl_id = aws_network_acl.private.id
}

# NACL for Public Subnets
resource "aws_network_acl" "public" {
  vpc_id = aws_vpc.main.id

  tags = merge(var.tags, {
    Name = "${var.vpc_name}-public-nacl"
  })
}

# Inbound Rules for Public Subnets
resource "aws_network_acl_rule" "public_inbound_http" {
  network_acl_id = aws_network_acl.public.id
  rule_number    = 100
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  from_port      = 80
  to_port        = 80
  egress         = false
}

resource "aws_network_acl_rule" "public_inbound_https" {
  network_acl_id = aws_network_acl.public.id
  rule_number    = 110
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  from_port      = 443
  to_port        = 443
  egress         = false
}

# Outbound Rules for Public Subnets
resource "aws_network_acl_rule" "public_outbound_all" {
  network_acl_id = aws_network_acl.public.id
  rule_number    = 100
  protocol       = "-1"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  egress         = true
}

# Associate Public NACL with Public Subnets
resource "aws_network_acl_association" "public" {
  for_each      = aws_subnet.public
  subnet_id     = each.value.id
  network_acl_id = aws_network_acl.public.id
}

# Security Group for Backend Services
resource "aws_security_group" "backend" {
  name        = "${var.vpc_name}-backend-sg"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "Allow traffic from the load balancer"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [aws_subnet.public[data.aws_availability_zones.available.names[0]].cidr_block] # Replace with load balancer IP/CIDR
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(var.tags, {
    Name = "${var.vpc_name}-backend-sg"
  })
}
