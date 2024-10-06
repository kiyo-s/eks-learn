output "aws_iam_role_arn" {
  value = aws_eks_node_group.main.node_role_arn
}

output "security_group_ids" {
  value = aws_launch_template.main.network_interfaces[*].security_groups
}

output "autoscaling_group_name" {
  value = aws_eks_node_group.main.resources[0].autoscaling_groups[*].name
}
