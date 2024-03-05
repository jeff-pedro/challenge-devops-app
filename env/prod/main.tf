terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.38.0"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region = var.region
}

locals {
  app_name         = "aluraflix"
  vpc_id           = module.vpc.vpc_id
  subnet1          = module.vpc.subnet1_id
  subnet2          = module.vpc.subnet2_id
  sg_allow_http    = module.vpc.sg_allow_http_id
  sg_dafault       = module.vpc.sg_default_id
  asg_arn          = module.ec2.asg_arn
  lb_target_group  = module.ec2.lb_target_group
}

module "vpc" {
  source = "../../infra/vpc"

  name = local.app_name
  cidr = "10.0.0.0/16"
  azs  = ["us-east-2a", "us-east-2b"]

  tags = {
    Terraform   = "true"
    Environment = "prod"
  }
}

module "ec2" {
  source = "../../infra/ec2"

  name          = local.app_name
  key           = "ecs-prod"
  vpc_id        = local.vpc_id
  subnet1       = local.subnet1
  subnet2       = local.subnet2
  sg_allow_http = local.sg_allow_http
  sg_default    = local.sg_dafault

  tags = {
    Terraform   = "true"
    Environment = "prod"
  }
}

module "ecs" {
  source = "../../infra/ecs"

  name            = local.app_name
  asg_arn         = local.asg_arn
  lb_target_group = local.lb_target_group
  image_name      = "aluraflix-api"
  image_version   = "latest"
  subnet1         = local.subnet1
  subnet2         = local.subnet2
}
