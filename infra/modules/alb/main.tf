resource "aws_alb" "gatus_alb" {
  load_balancer_type = "application"
  name = "gatus-alb"
  security_groups = [ var.alb_sg ]
  subnets = var.alb_subnet
}

resource "aws_alb_target_group" "alb_tg" {
  name = "gatus-alb-tg"
  target_type = "alb"
  port = "80"
  protocol = "TCP"
  vpc_id = var.alb_vpc_id
}

resource "aws_alb_target_group_attachment" "alb_tg_attach" {
  target_group_arn = aws_alb_target_group.alb_tg.arn
  target_id = var.alb_tg_ip
}