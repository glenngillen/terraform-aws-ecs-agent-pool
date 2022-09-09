# Terraform Cloud self-hosted agent pool on ECS

A Terraform module to create a self-hosted agent pool that runs
on Fargate. It will allow you to have ephemeral containers
to process your Terraform Cloud runs, within a VPC that you control,
with whatever memory/CPU/base image dependencies you need to successfully
execute your runs.

Note: The starting assumption is that whatever image your define to use
_already_ has the TFC agent installed and starting on boot.

## Setup

* Set the `TFE_TOKEN` environment variable. It'll need to be a highly permissive token (i.e., on the `owners` team) as it needs to be able to create a new agent pool at an organizational level.
* Set the relevant variables to configure your AWS provider.
  
## Usage


```hcl
module "agents" {
  source            = "glenngillen/aws-ecs-agent-pool/module"
  version           = "1.0.0"

  org_name          = "acme-org"
  name              = "acme-agents"
}
```