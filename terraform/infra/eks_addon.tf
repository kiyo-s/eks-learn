// VPC CNI
data "aws_iam_policy" "vpc_cni" {
  arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
}

module "irsa_vpc_cni" {
  source                        = "terraform-aws-modules/iam/aws//modules/iam-assumable-role-with-oidc"
  version                       = "5.46.0"
  create_role                   = true
  role_name                     = "${local.name}-irsa-vpc-cni"
  provider_url                  = aws_eks_cluster.main.identity[0].oidc[0].issuer
  role_policy_arns              = [data.aws_iam_policy.vpc_cni.arn]
  oidc_fully_qualified_subjects = ["system:serviceaccount:kube-system:aws-node"]
}

resource "aws_eks_addon" "vpc_cni" {
  cluster_name             = aws_eks_cluster.main.name
  addon_name               = "vpc-cni"
  addon_version            = "v1.18.5-eksbuild.1"
  service_account_role_arn = module.irsa_vpc_cni.iam_role_arn
}

// kube-proxy
module "irsa_kube_proxy" {
  source                        = "terraform-aws-modules/iam/aws//modules/iam-assumable-role-with-oidc"
  version                       = "5.46.0"
  create_role                   = true
  role_name                     = "${local.name}-irsa-kube-proxy"
  provider_url                  = aws_eks_cluster.main.identity[0].oidc[0].issuer
  oidc_fully_qualified_subjects = ["system:serviceaccount:kube-system:kube-proxy"]
}

resource "aws_eks_addon" "kube_proxy" {
  cluster_name             = aws_eks_cluster.main.name
  addon_name               = "kube-proxy"
  addon_version            = "v1.31.0-eksbuild.5"
  service_account_role_arn = module.irsa_kube_proxy.iam_role_arn
}

// coredns
module "irsa_coredns" {
  source                        = "terraform-aws-modules/iam/aws//modules/iam-assumable-role-with-oidc"
  version                       = "5.46.0"
  create_role                   = true
  role_name                     = "${local.name}-irsa-coredns"
  provider_url                  = aws_eks_cluster.main.identity[0].oidc[0].issuer
  oidc_fully_qualified_subjects = ["system:serviceaccount:kube-system:kube-proxy"]
}

resource "aws_eks_addon" "coredns" {
  depends_on = [
    module.eks_node_group_system,
  ]

  cluster_name             = aws_eks_cluster.main.name
  addon_name               = "coredns"
  addon_version            = "v1.11.3-eksbuild.1"
  configuration_values     = "{\"nodeSelector\":{\"eks.amazonaws.com/nodegroup\":\"system\"}}"
  service_account_role_arn = module.irsa_coredns.iam_role_arn
}
