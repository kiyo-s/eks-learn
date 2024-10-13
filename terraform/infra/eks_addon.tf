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
