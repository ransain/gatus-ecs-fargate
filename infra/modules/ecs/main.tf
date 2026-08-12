resource "aws_ecs_cluster" "gatus_ecs" {
  name = "gatus-cluster"

  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}

data "aws_iam_policy_document" "assume_role" {
  statement {
    actions = ["sts:AssumeRole"]
    effect  = "Allow"
    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "ecs_iam_role" {
  name               = "ecs-gatus-TaskExecutionRole"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

resource "aws_iam_role_policy_attachment" "ecs_full_policy" {
  role       = aws_iam_role.ecs_iam_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

resource "aws_ecs_task_definition" "gatus_task_def" {
  family                   = "gatus-td"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = "256"
  memory                   = "512"
  container_definitions = jsonencode([
    {
      name      = "gatus-app"
      image     = var.container_image
      cpu       = 256
      memory    = 512
      essential = true
      portMappings = [
        {
          containerPort = 8080
          hostPort      = 8080
        }
      ]
    }
  ])
  execution_role_arn = aws_iam_role.ecs_iam_role.arn
}

resource "aws_ecs_service" "gatus" {
  name                          = "gatus-service"
  cluster                       = aws_ecs_cluster.gatus_ecs.arn
  task_definition               = aws_ecs_task_definition.gatus_task_def.arn
  launch_type                   = "FARGATE"
  desired_count                 = "2"
  availability_zone_rebalancing = "ENABLED"
  force_new_deployment          = true

  network_configuration {
    security_groups  = [var.security_group_id]
    subnets          = var.subnet_id
    assign_public_ip = false
  }

  load_balancer {
    container_name   = "gatus-app"
    container_port   = "8080"
    target_group_arn = var.target_group_arn
  }

  lifecycle {
    ignore_changes = [ task_definition ]
  }
}