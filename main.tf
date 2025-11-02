module "vpc" {
  source       = "./modules/vpc"
  project_name = var.project_name
}

module "eks" {
  source       = "./modules/eks"
  project_name = var.project_name
  vpc_id       = module.vpc.vpc_id
  subnet_ids   = module.vpc.private_subnet_ids
}

terraform {
  backend "s3" {
    bucket         = "terraform-state-kanishk"
    key            = "eks/terraform.tfstate"
    region         = "ap-south-1"
    encrypt        = true
  }
}
