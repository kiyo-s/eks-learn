// cluster-autoscaler
data "aws_iam_policy_document" "cluster_autoscaler" {
  statement {
    sid    = "AllowReadAccessForAutoscaler"
    effect = "Allow"
    actions = [
      "autoscaling:DescribeAutoScalingGroups",
      "autoscaling:DescribeAutoScalingInstances",
      "autoscaling:DescribeLaunchConfigurations",
      "autoscaling:DescribeScalingActivities",
      "ec2:DescribeImages",
      "ec2:DescribeInstanceTypes",
      "ec2:DescribeLaunchTemplateVersions",
      "ec2:GetInstanceTypesFromInstanceRequirements",
      "eks:DescribeNodegroup"
    ]
    resources = ["*"]
  }
  statement {
    sid    = "AllowWriteAccessForAutoscaler"
    effect = "Allow"
    actions = [
      "autoscaling:SetDesiredCapacity",
      "autoscaling:TerminateInstanceInAutoScalingGroup"
    ]
    resources = ["*"]
  }
}

resource "aws_iam_policy" "cluster_autoscaler" {
  name        = "${local.name}-cluster-autoscaler"
  description = "Policy for cluster-autoscaler"
  policy      = data.aws_iam_policy_document.cluster_autoscaler.json
}

module "irsa_cluster_autoscaler" {
  source                        = "terraform-aws-modules/iam/aws//modules/iam-assumable-role-with-oidc"
  version                       = "5.46.0"
  create_role                   = true
  role_name                     = "${local.name}-irsa-cluster-autoscaler"
  provider_url                  = aws_eks_cluster.main.identity[0].oidc[0].issuer
  role_policy_arns              = [aws_iam_policy.cluster_autoscaler.arn]
  oidc_fully_qualified_subjects = ["system:serviceaccount:cluster-autoscaler:cluster-autoscaler"]
}
