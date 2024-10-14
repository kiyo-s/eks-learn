// IAM
resource "aws_iam_role" "main" {
  name = "${var.resource_name_prefix}-managed-nodegroup"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      },
    ]
  })

  tags = {
    Name = "${var.resource_name_prefix}-managed-nodegroup"
  }
}

resource "aws_iam_role_policy_attachment" "eks_worker_node_policy" {
  role       = aws_iam_role.main.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
}

resource "aws_iam_role_policy_attachment" "eks_cni_policy" {
  role       = aws_iam_role.main.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
}

resource "aws_iam_role_policy_attachment" "eks_container_registry_read_only" {
  role       = aws_iam_role.main.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}

resource "aws_iam_role_policy_attachment" "ssm_managed_ec2_instance_default_policy" {
  role       = aws_iam_role.main.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedEC2InstanceDefaultPolicy"
}

// Security Group
resource "aws_security_group" "main" {
  name   = "${var.resource_name_prefix}-managed-nodegroup"
  vpc_id = var.vpc_id

  tags = {
    Name = "${var.resource_name_prefix}-managed-nodegroup"
  }
}

resource "aws_security_group_rule" "ingress_self" {
  type              = "ingress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  security_group_id = aws_security_group.main.id
  self              = true
}

resource "aws_security_group_rule" "ingress_from_cluster" {
  type                     = "ingress"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
  security_group_id        = aws_security_group.main.id
  source_security_group_id = var.eks_cluster_security_group_id
}

resource "aws_security_group_rule" "egress_all" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  security_group_id = aws_security_group.main.id
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "eks_cluster_ingress_eks_node_group" {
  type                     = "ingress"
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"
  security_group_id        = var.eks_cluster_security_group_id
  source_security_group_id = aws_security_group.main.id
}

// Launch Template
resource "aws_launch_template" "main" {
  name = "${var.resource_name_prefix}-managed-nodegroup"

  image_id      = var.ami_id
  instance_type = var.node_resources.instance_type

  user_data = data.cloudinit_config.eks_node_group.rendered

  metadata_options {
    http_endpoint               = "enabled"
    http_tokens                 = "required"
    http_put_response_hop_limit = 2
  }

  network_interfaces {
    security_groups = [
      aws_security_group.main.id
    ]
  }

  tag_specifications {
    resource_type = "instance"
    tags = merge(
      var.tags,
      {
        Name = "${var.resource_name_prefix}-managed-nodegroup",
      }
    )
  }

  tag_specifications {
    resource_type = "volume"
    tags = merge(
      var.tags,
      {
        Name = "${var.resource_name_prefix}-managed-nodegroup",
      }
    )
  }

  tags = {
    Name = "${var.resource_name_prefix}-managed-nodegroup"
  }
}

// Managed Node Group
resource "aws_eks_node_group" "main" {
  depends_on = [
    aws_security_group_rule.eks_cluster_ingress_eks_node_group,
  ]

  cluster_name    = var.eks_cluster_name
  node_group_name = var.node_group_name

  node_role_arn = aws_iam_role.main.arn
  subnet_ids    = var.subnet_ids

  launch_template {
    name    = aws_launch_template.main.name
    version = aws_launch_template.main.latest_version
  }

  scaling_config {
    desired_size = var.node_resources.desired_size
    max_size     = var.node_resources.max_size
    min_size     = var.node_resources.min_size
  }

  update_config {
    max_unavailable_percentage = var.max_unavailable_percentage
  }

  timeouts {
    create = var.operational_timeout
    delete = var.operational_timeout
    update = var.operational_timeout
  }

  labels = var.k8s_node_labels

  tags = var.tags
}

resource "aws_autoscaling_group_tag" "cluster_autoscaler" {
  for_each = var.is_enabled_cluster_autoscaler ? {
    "k8s.io/cluster-autoscaler/enabled" : "true",
    "k8s.io/cluster-autoscaler/${var.eks_cluster_name}" : "owned",
  } : {}

  autoscaling_group_name = aws_eks_node_group.main.resources[0].autoscaling_groups[0].name

  tag {
    key   = each.key
    value = each.value

    propagate_at_launch = false
  }
}
