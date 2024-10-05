resource "aws_eks_cluster" "main" {
  name     = local.name
  version  = "1.31"
  role_arn = aws_iam_role.eks_cluster.arn

  vpc_config {
    security_group_ids      = [aws_security_group.eks_cluster.id]
    subnet_ids              = values(aws_subnet.private)[*].id
    endpoint_private_access = false
    endpoint_public_access  = true
    public_access_cidrs     = var.eks_cluster_access_cidrs
    vpc_id                  = aws_vpc.main.id
  }

  depends_on = [
    aws_iam_role_policy_attachment.eks_cluster_amazon_eks_cluster_policy,
    aws_iam_role_policy_attachment.eks_cluster_amazon_eks_service_policy,
    aws_iam_role_policy_attachment.eks_cluster_amazon_eks_vpc_resource_controller_policy,
    aws_security_group_rule.eks_cluster_egress_all,
  ]
}

data "aws_iam_policy_document" "eks_cluster_assume_role" {
  statement {
    sid = "EksClusterAssumeRole"

    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["eks.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "eks_cluster" {
  name               = "${local.name}-eks-cluster"
  assume_role_policy = data.aws_iam_policy_document.eks_cluster_assume_role.json
  path               = "/${local.state}/"

  tags = {
    Name = "${local.name}-eks-cluster"
  }
}

resource "aws_iam_role_policy_attachment" "eks_cluster_amazon_eks_cluster_policy" {
  role       = aws_iam_role.eks_cluster.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}

resource "aws_iam_role_policy_attachment" "eks_cluster_amazon_eks_service_policy" {
  role       = aws_iam_role.eks_cluster.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
}

resource "aws_iam_role_policy_attachment" "eks_cluster_amazon_eks_vpc_resource_controller_policy" {
  role       = aws_iam_role.eks_cluster.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
}

resource "aws_security_group" "eks_cluster" {
  name   = "${local.name}-eks-cluster"
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${local.name}-eks-cluster"
  }
}

resource "aws_security_group_rule" "eks_cluster_egress_all" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  security_group_id = aws_security_group.eks_cluster.id
  cidr_blocks       = ["0.0.0.0/0"]
}
