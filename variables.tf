variable "desired_count" {
  description = "Desired count of tfc-agents to run."
  default     = 0
}

variable "ip_cidr_vpc" {
  description = "IP CIDR for VPC"
  default     = "172.31.0.0/16"
}

variable "org_name" {
  description = "Organization to create agent pool in."
}
variable "name" {
  description = "Name for the agent pool & resources."
}

variable "task_cpu" {
  description = "The total number of cpu units used by the task."
  default     = 4096
}

variable "task_mem" {
  description = "The total amount (in MiB) of memory used by the task."
  default     = 8192
}

variable "task_def_cpu" {
  description = "The number of cpu units used by the task at the container definition level."
  default     = 1024
}

variable "task_def_mem" {
  description = "The amount (in MiB) of memory used by the task at the container definition level."
  default     = 2048
}

variable "image" {
  description = "Image to run on ECS tasks, must include the tfc-agent."
  default = "hashicorp/tfc-agent:latest"
}