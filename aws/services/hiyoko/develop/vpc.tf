# ====================================================
# VPC
# ====================================================
module "vpc_main" {
  source         = "../modules/vpc"
  vpc_cidr       = var.vpc_cidr
  project        = var.project
  environment    = var.environment
  public_subnets = [
    {
      availability_zone = var.availability_zone["a"]
      cidr             = var.subnets_cidr["public_a"]
    },
    {
      availability_zone = var.availability_zone["c"]
      cidr             = var.subnets_cidr["public_c"]
    }
  ]
  private_subnets = [
    {
      availability_zone = var.availability_zone["a"]
      cidr             = var.subnets_cidr["private_a"]
    },
    {
      availability_zone = var.availability_zone["c"]
      cidr             = var.subnets_cidr["private_c"]
    }
  ]
}
