module "acm" {
  source = "./modules/acm"
}

module "alb" {
  source     = "./modules/alb"
  alb_sg     = module.vpc.sg_id
  alb_vpc_id = module.vpc.vpc_id
  alb_subnet = module.vpc.pub_sub_id
}

module "ecr" {
  source = "./modules/ecr"
}

module "ecs" {
  source          = "./modules/ecs"
  container_image = "${module.ecr.ecr_url}:latest"
}

module "r53" {
  source = "./modules/route53"
  hosted_zone = "www.ransain.com"
  ttl = "172800"
}

module "vpc" {
  source = "./modules/vpc"
}