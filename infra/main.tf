module "acm" {
  source = "./modules/acm"
}

module "alb" {
  source = "./modules/alb"
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