output "cluster_role_arn" {
  value = aws_iam_role.cluster.arn
}

output "node_role_arn" {
  value = aws_iam_role.node.arn
}

output "alb_ingress_role_arn" {
  value = aws_iam_role.alb_ingress.arn
}
