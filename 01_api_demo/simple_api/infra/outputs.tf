output "vpc_id" {
  description = "The VPC ID"
  value       = module.vpc.vpc_id
}

output "public_subnet_ids" {
  description = "List of public subnet IDs"
  value       = module.vpc.public_subnet_ids
}

output "cluster_arn" {
  description = "ECS Cluster ARN"
  value       = module.ecs_cluster.cluster_arn
}

output "cluster_name" {
  description = "ECS Cluster name"
  value       = module.ecs_cluster.cluster_name
}

output "alb_arn" {
  description = "Application Load Balancer ARN"
  value       = module.alb.alb_arn
}

output "alb_dns_name" {
  description = "Application Load Balancer DNS name"
  # if your alb module exports `dns_name`, use `module.alb.dns_name`;
  # if it exports `alb_dns_name`, change this line to module.alb.alb_dns_name
  value = module.alb.dns_name
}

output "listener_arn" {
  description = "ALB listener ARN"
  value       = module.alb.listener_arn
}

output "alb_security_group_id" {
  description = "Security Group ID for the ALB"
  value       = module.alb.security_group_id
}

output "repository_url" {
  description = "ECR repository URL"
  value       = module.ecr.repository_url
}
