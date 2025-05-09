variable "region" {
  description = "AWS region to deploy into"
  type        = string
}

variable "prefix" {
  description = "Name prefix for all resources"
  type        = string
}

variable "cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidrs" {
  description = "List of CIDR blocks for public subnets"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "public_azs" {
  description = "Availability zones (optional; AWS picks if empty)"
  type        = list(string)
  default     = []
}

variable "image_url" {
  description = "ECR image URL (e.g. 123456789012.dkr.ecr.us-east-1.amazonaws.com/simple-api:latest)"
  type        = string
}

variable "db_username" {
  description = "Database username"
  type        = string
}

variable "db_password" {
  description = "Database password"
  type        = string
}

variable "db_name" {
  description = "Database name"
  type        = string
}
