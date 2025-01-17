variable "project" {
  description = "The project name"
  type        = string
  default     = "hiyoko"
}

variable "environment" {
  description = "The environment (e.g., develop, staging, production)"
  type        = string
  default     = "develop"
}

variable "keypair_relative_path" {
  description = "The key pair"
  type        = string
  default     = "./.ssh/hiyoko-dev-keypair.pub"
}

variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "subnets_cidr" {
  description = "The CIDR blocks for subnets"
  type        = map(string)
  default = {
    public_a  = "10.0.1.0/24"
    public_c  = "10.0.2.0/24"
    private_a = "10.0.3.0/24"
    private_c = "10.0.4.0/24"
  }
}

variable "availability_zone" {
  description = "The availability zones for subnets"
  type        = map(string)
  default = {
    a = "ap-northeast-1a"
    c = "ap-northeast-1c"
  }
}
