module "acm" {
  source = "./modules/acm"
}

module "alb" {
  source     = "./modules/alb"
  alb_sg     = module.vpc.sg_id
  alb_vpc_id = module.vpc.vpc_id
  alb_subnet = [ module.vpc.pub_sub_id ]
  alb_tg_ip  = mo
}

module "ecr" {
  source = "./modules/ecr"
}

module "ecs" {
  source          = "./modules/ecs"
  container_image = "${var.ecr_repo}:latest"
}

module "r53" {
  source = "./modules/route53"
}

module "vpc" {
  source = "./modules/vpc"
}