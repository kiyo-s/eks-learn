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

// Security Group
resource "aws_security_group" "main" {
  name   = "${var.resource_name_prefix}-managed-nodegroup"
  vpc_id = var.vpc_id

  tags = {
    Name = "${var.resource_name_prefix}-managed-nodegroup"
  }
}

// Launch Template
resource "aws_launch_template" "main" {
  name = "${var.resource_name_prefix}-managed-nodegroup"

  image_id      = var.ami_id
  instance_type = var.node_resources.instance_type

  metadata_options {
    http_endpoint               = "enabled"
    http_tokens                 = "required"
    http_put_response_hop_limit = 2
  }

  network_interfaces {
    security_groups = aws_security_group.main.id
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
  cluster_name    = var.eks_cluster_name
  node_group_name = var.resource_name_prefix

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

  labels = merge(
    var.k8s_node_labels,
    var.is_enabled_cluster_autoscaler ? { "k8s.io/cluster-autoscaler/enabled" = "true" } : {}
  )

  tags = var.tags
}
