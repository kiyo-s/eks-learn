<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.9.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.71.0 |
| <a name="provider_cloudinit"></a> [cloudinit](#provider\_cloudinit) | 2.3.5 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_autoscaling_group_tag.cluster_autoscaler](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/autoscaling_group_tag) | resource |
| [aws_eks_node_group.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_node_group) | resource |
| [aws_iam_role.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.eks_cni_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.eks_container_registry_read_only](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.eks_worker_node_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.ssm_managed_ec2_instance_default_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_launch_template.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/launch_template) | resource |
| [aws_security_group.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group_rule.egress_all](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.eks_cluster_ingress_eks_node_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.ingress_from_cluster](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.ingress_self](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [cloudinit_config.eks_node_group](https://registry.terraform.io/providers/hashicorp/cloudinit/latest/docs/data-sources/config) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ami_id"></a> [ami\_id](#input\_ami\_id) | EKS ノードで使用する AMI ID を指定してください。 | `string` | n/a | yes |
| <a name="input_cluster_ca"></a> [cluster\_ca](#input\_cluster\_ca) | EKS クラスタの CA データを指定してください。 | `string` | n/a | yes |
| <a name="input_cluster_cidr"></a> [cluster\_cidr](#input\_cluster\_cidr) | EKS クラスタの CIDR を指定してください。 | `string` | n/a | yes |
| <a name="input_cluster_endpoint"></a> [cluster\_endpoint](#input\_cluster\_endpoint) | EKS クラスタのエンドポイントを指定してください。 | `string` | n/a | yes |
| <a name="input_eks_cluster_name"></a> [eks\_cluster\_name](#input\_eks\_cluster\_name) | EKS クラスタの名前を指定してください。 | `string` | n/a | yes |
| <a name="input_eks_cluster_security_group_id"></a> [eks\_cluster\_security\_group\_id](#input\_eks\_cluster\_security\_group\_id) | EKS クラスタのセキュリティグループ ID を指定してください。 | `string` | n/a | yes |
| <a name="input_is_enabled_cluster_autoscaler"></a> [is\_enabled\_cluster\_autoscaler](#input\_is\_enabled\_cluster\_autoscaler) | EKS クラスタのオートスケーラーを有効にするかどうかを指定してください。 | `bool` | `false` | no |
| <a name="input_k8s_node_labels"></a> [k8s\_node\_labels](#input\_k8s\_node\_labels) | EKS ノードに付与する Kubernetes ノードラベルを指定してください。 | `map(string)` | `null` | no |
| <a name="input_max_unavailable_percentage"></a> [max\_unavailable\_percentage](#input\_max\_unavailable\_percentage) | EKS ノードのアップデート時に許容する最大のアンアベイラビリティを指定してください。 | `number` | `10` | no |
| <a name="input_node_group_name"></a> [node\_group\_name](#input\_node\_group\_name) | EKS ノードグループの名前を指定してください。 | `string` | n/a | yes |
| <a name="input_node_resources"></a> [node\_resources](#input\_node\_resources) | EKS ノードのリソースを指定してください。 | <pre>object({<br/>    instance_type = string<br/>    min_size      = number<br/>    max_size      = number<br/>    desired_size  = number<br/>  })</pre> | n/a | yes |
| <a name="input_operational_timeout"></a> [operational\_timeout](#input\_operational\_timeout) | リソースの作成・更新・削除にかかるタイムアウト時間を指定してください。 | `string` | `"60m"` | no |
| <a name="input_resource_name_prefix"></a> [resource\_name\_prefix](#input\_resource\_name\_prefix) | リソース名に付与するプレフィックスを指定してください。 | `string` | n/a | yes |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | EKS ノードを配置するサブネットの ID を指定してください。 | `list(string)` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | リソースに付与するタグを指定してください。 | `map(string)` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | EKS ノードを配置する VPC の ID を指定してください。 | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_autoscaling_group_name"></a> [autoscaling\_group\_name](#output\_autoscaling\_group\_name) | n/a |
| <a name="output_aws_iam_role_arn"></a> [aws\_iam\_role\_arn](#output\_aws\_iam\_role\_arn) | n/a |
| <a name="output_security_group_ids"></a> [security\_group\_ids](#output\_security\_group\_ids) | n/a |
<!-- END_TF_DOCS -->
