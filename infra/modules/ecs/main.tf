resource "aws_ecs_cluster" "gatus_ecs" {
  name = "gatus-cluster"

  setting {
    name = "containerInsights"
    value = "enabled"
  }
}

