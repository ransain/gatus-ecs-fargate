output "cluster_id" {
  description = "id of the cluster"
  value       = aws_ecs_cluster.gatus_ecs.id
}