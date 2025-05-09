# 1) VPC
resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr
  tags = { Name = "${var.alb_name}-vpc" }
}

# 2) Public Subnets
resource "aws_subnet" "public" {
  count                   = length(var.public_subnet_cidrs)
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet_cidrs[count.index]
  availability_zone       = var.azs[count.index]
  map_public_ip_on_launch = true
  tags                    = { Name = "${var.alb_name}-public-${count.index}" }
}

# 3) Internet Gateway + Public Route Table
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
  tags   = { Name = "${var.alb_name}-igw" }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = { Name = "${var.alb_name}-public-rt" }
}

resource "aws_route_table_association" "public" {
  count          = length(aws_subnet.public)
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}

# 4) ALB SG
resource "aws_security_group" "alb" {
  name        = "${var.alb_name}-sg"
  description = "Allow HTTP in"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# 4) Now your service modules
module "alb" {
  source             = "./modules/alb"
  name               = var.alb_name
  subnet_ids         = aws_subnet.public[*].id
  security_group_ids = [aws_security_group.alb.id]
  scheme             = var.scheme
  region = var.region
}

module "ecr" {
  source = "./modules/ecr"
  name   = var.ecr_name
  region = var.region
}

module "ecs_cluster" {
  source       = "./modules/ecs-cluster"
  cluster_name = var.cluster_name
  region = var.region
}





# module "alb" {
#   source             = "./modules/alb"
#   name               = var.alb_name
#   subnet_ids         = var.subnet_ids
#   security_group_ids = var.security_group_ids
#   scheme             = var.scheme
#   region             = var.region
# }
# 
# module "ecr" {
#   source = "./modules/ecr"
#   name   = var.ecr_name
#   region = var.region
# }
# 
# module "ecs_cluster" {
#   source       = "./modules/ecs-cluster"
#   cluster_name = var.cluster_name
#   region       = var.region
# }


