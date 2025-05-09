variable "name" {
  description = "The name of the ALB"
  type        = string
}

variable "subnet_ids" {
  description = "A list of subnet IDs to attach the ALB to"
  type        = list(string)
}

variable "security_group_ids" {
  description = "A list of security group IDs to associate with the ALB"
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
