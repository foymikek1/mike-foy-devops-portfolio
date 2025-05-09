output "alb_arn" {
  description = "ARN of the ALB"
  value       = aws_lb.alb.arn
}

output "dns_name" {
  description = "DNS name of the ALB"
  value       = aws_lb.alb.dns_name
}

output "listener_arn" {
  description = "ARN of the ALB listener"
  value       = aws_lb_listener.listener.arn
}

output "security_group_id" {
  description = "Security Group ID for the ALB"
  value       = aws_security_group.alb_sg.id
}
