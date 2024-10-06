<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.9.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.70.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_eks_node_group.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_node_group) | resource |
| [aws_iam_role.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_launch_template.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/launch_template) | resource |
| [aws_security_group.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ami_id"></a> [ami\_id](#input\_ami\_id) | EKS ノードで使用する AMI ID を指定してください。 | `string` | n/a | yes |
| <a name="input_eks_cluster_name"></a> [eks\_cluster\_name](#input\_eks\_cluster\_name) | EKS クラスタの名前を指定してください。 | `string` | n/a | yes |
| <a name="input_is_enabled_cluster_autoscaler"></a> [is\_enabled\_cluster\_autoscaler](#input\_is\_enabled\_cluster\_autoscaler) | EKS クラスタのオートスケーラーを有効にするかどうかを指定してください。 | `bool` | `false` | no |
| <a name="input_k8s_node_labels"></a> [k8s\_node\_labels](#input\_k8s\_node\_labels) | EKS ノードに付与する Kubernetes ノードラベルを指定してください。 | `map(string)` | `null` | no |
| <a name="input_max_unavailable_percentage"></a> [max\_unavailable\_percentage](#input\_max\_unavailable\_percentage) | EKS ノードのアップデート時に許容する最大のアンアベイラビリティを指定してください。 | `number` | `10` | no |
| <a name="input_node_resources"></a> [node\_resources](#input\_node\_resources) | EKS ノードのリソースを指定してください。 | <pre>object({<br/>    instance_type    = string<br/>    min_size         = number<br/>    max_size         = number<br/>    desired_size = number<br/>  })</pre> | n/a | yes |
| <a name="input_operational_timeout"></a> [operational\_timeout](#input\_operational\_timeout) | リソースの作成・更新・削除にかかるタイムアウト時間を指定してください。 | `string` | `"60m"` | no |
| <a name="input_resource_name_prefix"></a> [resource\_name\_prefix](#input\_resource\_name\_prefix) | リソース名に付与するプレフィックスを指定してください。 | `string` | n/a | yes |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | EKS ノードを配置するサブネットの ID を指定してください。 | `list(string)` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | リソースに付与するタグを指定してください。 | `map(string)` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | EKS ノードを配置する VPC の ID を指定してください。 | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->