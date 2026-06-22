module "acm" {
  source = "./modules/acm"
}

module "alb" {
  source = "./modules/alb"
  alb_sg = module.vpc.security_groups
  alb_vpc_id = module.vpc.vpc_id
  alb_subnet = [ module.vpc.aws_subnet.pub_sub ]
  alb_tg_ip = 
}

module "ecr" {
  source = "./modules/ecr"
}

module "ecs" {
  source = "./modules/ecs"
}

module "r53" {
  source = "./modules/route53"
}

module "vpc" {
  source = "./modules/vpc"
}