#####################################
# Provider Settings
#####################################
provider "aws" {
  version = "~> 2.57"
  profile = var.profile
  region  = var.region
}

#####################################
# Module Settings
#####################################
module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "vpc-${local.suffix_kebab[terraform.workspace]}"
  cidr = "10.0.0.0/16"

  azs                  = ["${var.region}a", "${var.region}c"]
  enable_dns_hostnames = true
  #private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets = ["10.0.101.0/24"]

  tags = {
    Terraform = "true"
    Name      = local.suffix[terraform.workspace]
  }
}

module "service" {
  source = "./modules/service"

  bucket_name         = var.bucket_name[terraform.workspace]
  cidr_blocks_dev     = var.cidr_blocks_dev
  path_to_ssh_key_pub = var.path_to_ssh_key_pub
  subnets             = module.vpc.public_subnets
  suffix              = local.suffix[terraform.workspace]
  suffix_kebab        = local.suffix_kebab[terraform.workspace]
  vpc_id              = module.vpc.vpc_id

  tags = {
    Terraform = "true"
    Name      = local.suffix[terraform.workspace]
  }
}