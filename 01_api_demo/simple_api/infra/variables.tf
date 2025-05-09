# 01_api_demo/simple_api/infra/variables.tf

variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "vpc_cidr" {
  description = "CIDR block for the new VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidrs" {
  description = "List of CIDRs for public subnets (one per AZ)"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "azs" {
  description = "List of AZs to place those subnets in (must be same length as public_subnet_cidrs)"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
}

variable "alb_name" {
  description = "Name for the ALB"
  type        = string
  default     = "simple-api-alb"
}

variable "scheme" {
  description = "ALB scheme (internet-facing or internal)"
  type        = string
  default     = "internet-facing"
}

variable "ecr_name" {
  description = "Name for the ECR repository"
  type        = string
  default     = "simple-api"
}

variable "cluster_name" {
  description = "Name for the ECS cluster"
  type        = string
  default     = "simple-api-cluster"
}

# ---------------------------------------------------------------------------
# These declarations match the Vars you pass in from Terratest
# ---------------------------------------------------------------------------

variable "image_url" {
  description = "Docker image URI for the service"
  type        = string
}

variable "db_username" {
  description = "Postgres username"
  type        = string
}

variable "db_password" {
  description = "Postgres password"
  type        = string
  sensitive   = true
}

variable "db_name" {
  description = "Postgres database name"
  type        = string
}

# Integration test / Terratest inputs
variable "image_url" {
  description = "The ECR image URI (including tag) to deploy"
  type        = string
}

variable "db_username" {
  description = "Postgres username"
  type        = string
}

variable "db_password" {
  description = "Postgres password"
  type        = string
  sensitive   = true
}

variable "db_name" {
  description = "Postgres database name"
  type        = string
}
