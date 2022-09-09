resource "aws_ecs_cluster" "tfc_agent" {
  name = "${var.name}-tfc-agent-cluster"
}

resource "aws_ecs_service" "tfc_agent" {
  name            = "${var.name}-tfc-agent-service"
  cluster         = aws_ecs_cluster.tfc_agent.id
  launch_type     = "FARGATE"
  task_definition = aws_ecs_task_definition.tfc_agent.arn
  desired_count   = var.desired_count
  network_configuration {
    security_groups  = [aws_security_group.tfc_agent.id]
    subnets          = [aws_subnet.tfc_agent.id]
    assign_public_ip = true
  }
  lifecycle {
    ignore_changes = [desired_count]
  }
}

resource "aws_ecs_task_definition" "tfc_agent" {
  family                   = "${var.name}-task"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  execution_role_arn       = aws_iam_role.agent_init.arn
  task_role_arn            = aws_iam_role.agent.arn
  cpu                      = var.task_cpu
  memory                   = var.task_mem
  container_definitions = jsonencode(
    [
      {
        name : "tfc-agent"
        image : var.image
        essential : true
        cpu : var.task_def_cpu
        memory : var.task_def_mem
        logConfiguration : {
          logDriver : "awslogs",
          options : {
            awslogs-create-group : "true",
            awslogs-group : "awslogs-tfc-agent"
            awslogs-region : local.region
            awslogs-stream-prefix : "awslogs-tfc-agent"
          }
        }
        environment = [
          {
            name  = "TFC_AGENT_SINGLE",
            value = "true"
          },
          {
            name  = "TFC_AGENT_NAME",
            value = "ECS_Fargate"
          }
        ]
        secrets = [
          {
            name      = "TFC_AGENT_TOKEN",
            valueFrom = aws_ssm_parameter.agent_token.arn
          }
        ]
      }
    ]
  )
}