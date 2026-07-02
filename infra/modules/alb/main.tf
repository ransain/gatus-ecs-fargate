resource "aws_alb" "gatus_alb" {
  load_balancer_type = "application"
  name               = "gatus-alb"
  security_groups    = [var.alb_sg]
  subnets            = var.alb_subnet
}

resource "aws_alb_target_group" "alb_tg" {
  name        = "gatus-alb-tg"
  target_type = "alb"
  port        = "8080"
  protocol    = "TCP"
  vpc_id      = var.alb_vpc_id
}

resource "aws_alb_listener" "http" {
  load_balancer_arn = aws_alb.gatus_alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

resource "aws_alb_listener" "https" {
  load_balancer_arn = aws_alb.gatus_alb.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  default_action {
    type = "forward"
    forward {
      target_group {
        arn = aws_alb_target_group.alb_tg.arn
      }
    }
  }
}