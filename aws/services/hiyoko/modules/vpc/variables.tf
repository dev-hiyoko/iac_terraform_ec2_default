variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  type        = string
}

variable "project" {
  description = "Project name"
  type        = string
}

variable "environment" {
  description = "Environment name (e.g., develop, staging, production)"
  type        = string
}

variable "public_subnets" {
  description = "List of public subnets with availability zones and CIDRs"
  type = list(object({
    availability_zone = string
    cidr              = string
  }))
}

variable "private_subnets" {
  description = "List of private subnets with availability zones and CIDRs"
  type = list(object({
    availability_zone = string
    cidr              = string
  }))
}
