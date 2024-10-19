module "eks_node_group_system" {
  source = "./modules/managed_nodegroup"

  resource_name_prefix = "${local.name}-node-group-system"
  node_group_name      = "system"
  tags                 = local.default_tags

  vpc_id     = aws_vpc.main.id
  subnet_ids = values(aws_subnet.private)[*].id

  eks_cluster_name              = aws_eks_cluster.main.name
  cluster_endpoint              = aws_eks_cluster.main.endpoint
  cluster_ca                    = aws_eks_cluster.main.certificate_authority[0].data
  cluster_cidr                  = aws_eks_cluster.main.kubernetes_network_config[0].service_ipv4_cidr
  eks_cluster_security_group_id = aws_security_group.eks_cluster.id

  ami_id = var.ami_id

  node_resources = var.node_resources_system

  k8s_node_labels = {
    type = "system"
  }

  max_unavailable_percentage = var.max_unavailable_percentage

  is_enabled_cluster_autoscaler = true
}

resource "aws_security_group_rule" "ingress_node_group_biz" {
  type                     = "ingress"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
  security_group_id        = module.eks_node_group_system.security_group_ids[0]
  source_security_group_id = module.eks_node_group_buisiness.security_group_ids[0]
}
