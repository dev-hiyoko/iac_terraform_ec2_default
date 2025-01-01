variable "project" {
  description = "The project name"
  type        = string
}

variable "environment" {
  description = "The environment (e.g., dev, prod)"
  type        = string
}

variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  type        = string
}

variable "subnets_cidr" {
  description = "The CIDR blocks for subnets"
  type        = map(string)
}

variable "availability_zone" {
  description = "The availability zones for subnets"
  type        = map(string)
}