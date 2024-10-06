module "eks_node_group_system" {
  source = "./modules/managed_nodegroup"

  resource_name_prefix = local.name
  tags                 = local.default_tags

  vpc_id     = aws_vpc.main.id
  subnet_ids = values(aws_subnet.private)[*].id

  eks_cluster_name = aws_eks_cluster.main.name
  ami_id           = var.ami_id

  node_resources = var.node_resources_system

  k8s_node_labels = {
    type = "system"
  }

  max_unavailable_percentage = var.max_unavailable_percentage

  is_enabled_cluster_autoscaler = true
}