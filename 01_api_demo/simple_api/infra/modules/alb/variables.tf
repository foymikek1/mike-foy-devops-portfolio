variable "name" {
  description = "The name of the ALB"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID for creating the ALB Security Group"
  type        = string
}

variable "subnet_ids" {
  description = "A list of subnet IDs to attach the ALB to"
  type        = list(string)
}

variable "scheme" {
  description = "Whether the LB is internal or internet-facing"
  type        = string
}

variable "region" {
  description = "The AWS region to deploy into"
  type        = string
}
