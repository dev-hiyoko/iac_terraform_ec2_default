# TODO localsで設定した方が良いものは修正する
variable "project" {
  description = "The project name"
  type        = string
  default     = "hiyoko"
}

variable "domain" {
  description = "The Domain"
  type        = string
  default     = "example.com"
}

variable "environment" {
  description = "The environment (e.g., develop, staging, production)"
  type        = string
  default     = "develop"
}

variable "availability_zone" {
  description = "The availability zones"
  type        = map(string)
  default = {
    a = "ap-northeast-1a"
    c = "ap-northeast-1c"
  }
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

variable "keypair_path" {
  description = "The key pair"
  type        = string
  default     = "./.ssh/hiyoko-dev-keypair.pub"
}

variable "app_ami" {
  description = "The APP EC2 instance ami filter"
  type        = string
  default     = "al2023-ami-2023.6.*.0-kernel-6.1-x86_64"
}

variable "ec2_instance_type" {
  description = "The EC2 instance type"
  type        = string
  default     = "t2.micro"
}
