# VPC & networking
output "vpc_id" {
  value = aws_vpc.main.id
}
output "public_subnet_ids" {
  value = aws_subnet.public[*].id
}
output "alb_security_group_id" {
  value = aws_security_group.alb.id
}

# Module outputs
output "alb_arn" {
  value = module.alb.alb_arn
}
output "alb_dns_name" {
  value = module.alb.dns_name
}
output "listener_arn" {
  value = module.alb.listener_arn
}

output "repository_arn" {
  value = module.ecr.repository_arn
}
output "repository_url" {
  value = module.ecr.repository_url
}

output "cluster_arn" {
  value = module.ecs_cluster.cluster_arn
}
output "cluster_name" {
  value = module.ecs_cluster.cluster_name
}



# output "alb_arn" {
#   description = "ARN of the ALB"
#   value       = module.alb.alb_arn
# }
# 
# output "alb_dns_name" {
#   description = "DNS name of the ALB"
#   value       = module.alb.dns_name
# }
# 
# output "listener_arn" {
#   description = "ARN of the ALB listener"
#   value       = module.alb.listener_arn
# }
# 
# output "repository_arn" {
#   description = "ARN of the ECR repository"
#   value       = module.ecr.repository_arn
# }
# 
# output "repository_url" {
#   description = "URL of the ECR repository"
#   value       = module.ecr.repository_url
# }
# 
# output "cluster_arn" {
#   description = "ARN of the ECS cluster"
#   value       = module.ecs_cluster.cluster_arn
# }
# 
# output "cluster_name" {
#   description = "Name of the ECS cluster"
#   value       = module.ecs_cluster.cluster_name
# }