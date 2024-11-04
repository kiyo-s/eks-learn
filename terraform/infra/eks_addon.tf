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

// amazon-ebs-csi-driver (for PostgreSQL)
data "aws_iam_policy" "csi_driver" {
  arn = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"
}

module "irsa_ebs_csi_driver" {
  source                        = "terraform-aws-modules/iam/aws//modules/iam-assumable-role-with-oidc"
  version                       = "5.46.0"
  create_role                   = true
  role_name                     = "${local.name}-irsa-ebs-csi-driver"
  provider_url                  = aws_eks_cluster.main.identity[0].oidc[0].issuer
  role_policy_arns              = [data.aws_iam_policy.csi_driver.arn]
  oidc_fully_qualified_subjects = ["system:serviceaccount:kube-system:ebs-csi-controller-sa"]
}

resource "aws_eks_addon" "ebs_csi_driver" {
  depends_on = [
    module.eks_node_group_system,
  ]

  cluster_name  = aws_eks_cluster.main.name
  addon_name    = "aws-ebs-csi-driver"
  addon_version = "v1.36.0-eksbuild.1"
  configuration_values = jsonencode({
    controller = {
      nodeSelector = {
        "eks.amazonaws.com/nodegroup" = "system"
      }
    },
  })
  service_account_role_arn = module.irsa_ebs_csi_driver.iam_role_arn
}

resource "kubernetes_storage_class_v1" "ebs_gp3" {
  metadata {
    name = "ebs-gp3"
    annotations = {
      "storageclass.kubernetes.io/is-default-class" = "true"
    }
  }

  // https://github.com/kubernetes-sigs/aws-ebs-csi-driver/blob/master/examples/kubernetes/storageclass/manifests/storageclass.yaml
  storage_provisioner    = "ebs.csi.aws.com"
  reclaim_policy         = "Delete"
  allow_volume_expansion = true
  volume_binding_mode    = "WaitForFirstConsumer"

  // https://github.com/kubernetes-sigs/aws-ebs-csi-driver/blob/master/docs/parameters.md
  parameters = {
    "csi.storage.k8s.io/fstype" = "ext4"
    type                        = "gp3"
    encrypted                   = "true"
  }
}
