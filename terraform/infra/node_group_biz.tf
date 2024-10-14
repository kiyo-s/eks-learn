module "eks_node_group_buisiness" {
  source = "./modules/managed_nodegroup"

  resource_name_prefix = "${local.name}-node-group-business"
  node_group_name      = "business"
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
    type = "business"
  }

  max_unavailable_percentage = var.max_unavailable_percentage

  is_enabled_cluster_autoscaler = true
}

data "aws_autoscaling_group" "eks_node_group_buisiness" {
  name = module.eks_node_group_buisiness.autoscaling_group_name[0]
}

resource "aws_autoscaling_group_tag" "eks_node_group_business_cluster_autoscaler" {
  for_each = {
    "k8s.io/cluster-autoscaler/enabled" : "true",
    "k8s.io/cluster-autoscaler/${aws_eks_cluster.main.name}" : "owned",
  }

  autoscaling_group_name = data.aws_autoscaling_group.eks_node_group_buisiness.name

  tag {
    key   = each.key
    value = each.value

    propagate_at_launch = false
  }
}
