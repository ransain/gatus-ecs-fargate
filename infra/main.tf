module "acm" {
  source  = "./modules/acm"
  zone_id = module.r53.zone_id
}

module "alb" {
  source          = "./modules/alb"
  alb_sg          = module.vpc.sg_id
  alb_vpc_id      = module.vpc.vpc_id
  alb_subnet      = module.vpc.pub_sub_id
  certificate_arn = module.acm.acm_arn
}

module "ecr" {
  source = "./modules/ecr"
}

module "ecs" {
  source          = "./modules/ecs"
  container_image = "${module.ecr.ecr_url}:latest"
}

module "r53" {
  source    = "./modules/route53"
  subdomain = var.subdomain_name
  alb_dns   = module.alb.alb_dns
  alb_zone  = module.alb.alb_zone_id
}

module "vpc" {
  source = "./modules/vpc"
}