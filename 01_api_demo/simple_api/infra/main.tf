terraform {
  required_version = ">= 1.3.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.region
}

# ─────────────────────────────────────────────────────────────────────────────
# 1) VPC Module
# ─────────────────────────────────────────────────────────────────────────────
module "vpc" {
  source              = "./modules/vpc"
  region              = var.region
  cidr_block          = var.cidr_block
  public_subnet_cidrs = var.public_subnet_cidrs
  public_azs          = var.public_azs
  vpc_name            = var.prefix
}

# ─────────────────────────────────────────────────────────────────────────────
# 2) ECS Cluster Module
# ─────────────────────────────────────────────────────────────────────────────
module "ecs_cluster" {
  source       = "./modules/ecs_cluster"
  region       = var.region # ← you must pass region here
  cluster_name = var.prefix
}

# ─────────────────────────────────────────────────────────────────────────────
# 3) Application Load Balancer Module
# ─────────────────────────────────────────────────────────────────────────────
module "alb" {
  source     = "./modules/alb"
  region     = var.region # ← and here
  name       = "${var.prefix}-alb"
  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.public_subnet_ids
  # security_group_ids = [module.ecs_cluster.security_group_id]
  scheme = "internet-facing"
}

# ─────────────────────────────────────────────────────────────────────────────
# 4) ECR Repository Module
# ─────────────────────────────────────────────────────────────────────────────
module "ecr" {
  source = "./modules/ecr"
  region = var.region # ← and here
  name   = var.prefix
}

# ─────────────────────────────────────────────────────────────────────────────
# 5) ECS Service Module
# ─────────────────────────────────────────────────────────────────────────────

module "ecs_service" {
  source            = "./modules/ecs_service"
  cluster_name      = module.ecs_cluster.cluster_name
  image_url         = var.image_url
  db_username       = var.db_username
  db_password       = var.db_password
  db_name           = var.db_name
  vpc_id            = module.vpc.vpc_id
  public_subnet_ids = module.vpc.public_subnet_ids
  alb_listener_arn  = module.alb.listener_arn
  alb_sg_id         = module.alb.security_group_id
}
