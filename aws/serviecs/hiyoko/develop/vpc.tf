# ====================================================
# VPC
# ====================================================
module "vpc" {
  source         = "../modules/vpc"
  vpc_cidr       = "10.0.0.0/16"
  project        = "my-project"
  environment    = "dev"
  public_subnets = [
    {
      availability_zone = "us-east-1a"
      cidr             = "10.0.1.0/24"
    },
    {
      availability_zone = "us-east-1c"
      cidr             = "10.0.2.0/24"
    }
  ]
  private_subnets = [
    {
      availability_zone = "us-east-1a"
      cidr             = "10.0.3.0/24"
    },
    {
      availability_zone = "us-east-1c"
      cidr             = "10.0.4.0/24"
    }
  ]
}

output "vpc_id" {
  value = module.vpc.vpc_id
}

output "public_subnet_ids" {
  value = module.vpc.public_subnet_ids
}

output "private_subnet_ids" {
  value = module.vpc.private_subnet_ids
}
