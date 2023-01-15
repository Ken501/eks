// Create VPC
resource "aws_vpc" "main" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = merge(
    var.additional_tags,
    {
       Name = "${var.app_name}-VPC"
    },
  )
}

// Default route table
resource "aws_default_route_table" "main_table" {
  default_route_table_id = aws_vpc.main.default_route_table_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = merge(
    var.additional_tags,
    {
       Name = "${var.app_name}-Main-Table"
    },
  )
}

// Default security group
resource "aws_default_security_group" "default" {
  vpc_id = aws_vpc.main.id

  ingress {
    protocol  = -1
    self      = true
    from_port = 0
    to_port   = 0
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  tags = merge(
    var.additional_tags,
    {
       Name = "${var.app_name}-Default-SG"
    },
  )
}

// Create and attach Internet Gateway
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = merge(
    var.additional_tags,
    {
       Name = "${var.app_name}-GW"
    },
  )
}

// Create Public Subnets
resource "aws_subnet" "public01" {
  vpc_id     = aws_vpc.main.id
  cidr_block = local.public_subnets[0]
  availability_zone = local.az[0]

  tags = merge(
    var.additional_tags,
    {
       Name = "${var.app_name}-Public-1"
    },
  )
}

resource "aws_subnet" "public02" {
  vpc_id = aws_vpc.main.id
  cidr_block = local.public_subnets[1]
  availability_zone = local.az[1]

  tags = merge(
    var.additional_tags,
    {
       Name = "${var.app_name}-Public-2"
    },
  )
}


// Create Private Subnets
resource "aws_subnet" "private01" {
    vpc_id = aws_vpc.main.id
    cidr_block = local.private_subnets[0]
    availability_zone = local.az[0]

  tags = merge(
    var.additional_tags,
    {
       Name = "${var.app_name}-Private-1"
    },
  )
}

resource "aws_subnet" "private02" {
    vpc_id = aws_vpc.main.id
    cidr_block = local.private_subnets[1]
    availability_zone = local.az[1]

  tags = merge(
    var.additional_tags,
    {
       Name = "${var.app_name}-Private-2"
    },
  )
}

// Route table

// Public route table
resource "aws_route_table" "public_route" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = merge(
    var.additional_tags,
    {
       Name = "${var.app_name}-GW-Table"
    },
  )
}

// Private route table


resource "aws_route_table" "private_route_01" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.gw01.id
  }

  tags = merge(
    var.additional_tags,
    {
       Name = "${var.app_name}-NAT-Table-1"
    },
  )
}

resource "aws_route_table" "private_route_02" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.gw02.id
  }

  tags = merge(
    var.additional_tags,
    {
       Name = "${var.app_name}-NAT-Table-2"
    },
  )
}

// Public associations

resource "aws_route_table_association" "public-sub01" {
  subnet_id      = aws_subnet.public01.id
  route_table_id = aws_route_table.public_route.id
}

resource "aws_route_table_association" "public-sub02" {
  subnet_id      = aws_subnet.public02.id
  route_table_id = aws_route_table.public_route.id
}

// Private associations

resource "aws_route_table_association" "private-sub01" {
  subnet_id      = aws_subnet.private01.id
  route_table_id = aws_route_table.private_route_01.id
}

resource "aws_route_table_association" "private-sub02" {
  subnet_id      = aws_subnet.private02.id
  route_table_id = aws_route_table.private_route_02.id
}

// EIP

resource "aws_eip" "nat-eip01" {
  vpc = true

  depends_on = [
    aws_vpc.main
  ]
}

resource "aws_eip" "nat-eip02" {
    vpc = true
    depends_on = [
    aws_vpc.main
  ]
}

// NAT Gateway

resource "aws_nat_gateway" "gw01" {
  allocation_id = aws_eip.nat-eip01.id
  subnet_id     = aws_subnet.public01.id

  tags = merge(
    var.additional_tags,
    {
       Name = "${var.app_name}-GW-1"
    },
  )
}

resource "aws_nat_gateway" "gw02" {
  allocation_id = aws_eip.nat-eip02.id
  subnet_id = aws_subnet.public02.id

  tags = merge(
    var.additional_tags,
    {
       Name = "${var.app_name}-GW-2"
    },
  )
}