data "tfe_organization" "this" {
  name = var.org_name
}

resource "tfe_agent_pool" "this" {
  name         = var.name
  organization = data.tfe_organization.this.name
}

resource "tfe_agent_token" "this" {
  agent_pool_id = tfe_agent_pool.this.id
  description   = "Dynamic agent pool token"
}

resource "aws_ssm_parameter" "agent_token" {
  name        = "${var.name}-tfc-agent-token"
  description = "Terraform Cloud agent token"
  type        = "SecureString"
  value       = tfe_agent_token.this.token
}
