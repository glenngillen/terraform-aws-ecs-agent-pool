output "cluster_name" {
  description = "Name of the ECS cluster that is created"
  value       = aws_ecs_cluster.tfc_agent.name
}

output "cluster_arn" {
  description = "ARN of the ECS cluster that is created"
  value       = aws_ecs_cluster.tfc_agent.arn
}

output "service_name" {
  description = "Name of the ECS service that is created"
  value       = aws_ecs_service.tfc_agent.name
}

output "service_arn" {
  description = "ARN of the ECS service that is created"
  value       = aws_ecs_service.tfc_agent.id
}

output "agent_iam_init_role_name" {
  description = "IAM Role that task will initialize using."
  value       = aws_iam_role.agent_init.name
}

output "agent_iam_role_name" {
  description = "IAM Role that the task will execute as."
  value       = aws_iam_role.agent.name
}