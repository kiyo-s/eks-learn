# infra

インフラリソースを管理する Terraform コード

## Usage

### init

```bash
ENV=dev && terraform init -backend-config="${ENV}/backend.tfvars"
```

### plan

```bash
ENV=dev && terraform plan -var-file="${ENV}/terraform.tfvars"
```

### apply

```bash
ENV=dev && terraform apply -var-file="${ENV}/terraform.tfvars"
```

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.9.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | 5.71.0 |
| <a name="requirement_cloudinit"></a> [cloudinit](#requirement\_cloudinit) | 2.3.5 |
| <a name="requirement_tls"></a> [tls](#requirement\_tls) | 4.0.6 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.71.0 |
| <a name="provider_tls"></a> [tls](#provider\_tls) | 4.0.6 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_eks_node_group_buisiness"></a> [eks\_node\_group\_buisiness](#module\_eks\_node\_group\_buisiness) | ./modules/managed_nodegroup | n/a |
| <a name="module_eks_node_group_system"></a> [eks\_node\_group\_system](#module\_eks\_node\_group\_system) | ./modules/managed_nodegroup | n/a |
| <a name="module_irsa_cluster_autoscaler"></a> [irsa\_cluster\_autoscaler](#module\_irsa\_cluster\_autoscaler) | terraform-aws-modules/iam/aws//modules/iam-assumable-role-with-oidc | 5.46.0 |
| <a name="module_irsa_coredns"></a> [irsa\_coredns](#module\_irsa\_coredns) | terraform-aws-modules/iam/aws//modules/iam-assumable-role-with-oidc | 5.46.0 |
| <a name="module_irsa_kube_proxy"></a> [irsa\_kube\_proxy](#module\_irsa\_kube\_proxy) | terraform-aws-modules/iam/aws//modules/iam-assumable-role-with-oidc | 5.46.0 |
| <a name="module_irsa_vpc_cni"></a> [irsa\_vpc\_cni](#module\_irsa\_vpc\_cni) | terraform-aws-modules/iam/aws//modules/iam-assumable-role-with-oidc | 5.46.0 |

## Resources

| Name | Type |
|------|------|
| [aws_eip.nat_gateway](https://registry.terraform.io/providers/hashicorp/aws/5.71.0/docs/resources/eip) | resource |
| [aws_eks_access_entry.administrator](https://registry.terraform.io/providers/hashicorp/aws/5.71.0/docs/resources/eks_access_entry) | resource |
| [aws_eks_access_policy_association.administrator](https://registry.terraform.io/providers/hashicorp/aws/5.71.0/docs/resources/eks_access_policy_association) | resource |
| [aws_eks_addon.coredns](https://registry.terraform.io/providers/hashicorp/aws/5.71.0/docs/resources/eks_addon) | resource |
| [aws_eks_addon.kube_proxy](https://registry.terraform.io/providers/hashicorp/aws/5.71.0/docs/resources/eks_addon) | resource |
| [aws_eks_addon.vpc_cni](https://registry.terraform.io/providers/hashicorp/aws/5.71.0/docs/resources/eks_addon) | resource |
| [aws_eks_cluster.main](https://registry.terraform.io/providers/hashicorp/aws/5.71.0/docs/resources/eks_cluster) | resource |
| [aws_iam_openid_connect_provider.eks](https://registry.terraform.io/providers/hashicorp/aws/5.71.0/docs/resources/iam_openid_connect_provider) | resource |
| [aws_iam_policy.cluster_autoscaler](https://registry.terraform.io/providers/hashicorp/aws/5.71.0/docs/resources/iam_policy) | resource |
| [aws_iam_role.eks_cluster](https://registry.terraform.io/providers/hashicorp/aws/5.71.0/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.eks_cluster_amazon_eks_cluster_policy](https://registry.terraform.io/providers/hashicorp/aws/5.71.0/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.eks_cluster_amazon_eks_service_policy](https://registry.terraform.io/providers/hashicorp/aws/5.71.0/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.eks_cluster_amazon_eks_vpc_resource_controller_policy](https://registry.terraform.io/providers/hashicorp/aws/5.71.0/docs/resources/iam_role_policy_attachment) | resource |
| [aws_internet_gateway.main](https://registry.terraform.io/providers/hashicorp/aws/5.71.0/docs/resources/internet_gateway) | resource |
| [aws_kms_alias.sops](https://registry.terraform.io/providers/hashicorp/aws/5.71.0/docs/resources/kms_alias) | resource |
| [aws_kms_key.sops](https://registry.terraform.io/providers/hashicorp/aws/5.71.0/docs/resources/kms_key) | resource |
| [aws_nat_gateway.main](https://registry.terraform.io/providers/hashicorp/aws/5.71.0/docs/resources/nat_gateway) | resource |
| [aws_route.private_to_nat_gateway](https://registry.terraform.io/providers/hashicorp/aws/5.71.0/docs/resources/route) | resource |
| [aws_route.public_internet_gateway](https://registry.terraform.io/providers/hashicorp/aws/5.71.0/docs/resources/route) | resource |
| [aws_route_table.private](https://registry.terraform.io/providers/hashicorp/aws/5.71.0/docs/resources/route_table) | resource |
| [aws_route_table.public](https://registry.terraform.io/providers/hashicorp/aws/5.71.0/docs/resources/route_table) | resource |
| [aws_route_table_association.private](https://registry.terraform.io/providers/hashicorp/aws/5.71.0/docs/resources/route_table_association) | resource |
| [aws_route_table_association.public](https://registry.terraform.io/providers/hashicorp/aws/5.71.0/docs/resources/route_table_association) | resource |
| [aws_security_group.eks_cluster](https://registry.terraform.io/providers/hashicorp/aws/5.71.0/docs/resources/security_group) | resource |
| [aws_security_group_rule.eks_cluster_egress_all](https://registry.terraform.io/providers/hashicorp/aws/5.71.0/docs/resources/security_group_rule) | resource |
| [aws_subnet.private](https://registry.terraform.io/providers/hashicorp/aws/5.71.0/docs/resources/subnet) | resource |
| [aws_subnet.public](https://registry.terraform.io/providers/hashicorp/aws/5.71.0/docs/resources/subnet) | resource |
| [aws_vpc.main](https://registry.terraform.io/providers/hashicorp/aws/5.71.0/docs/resources/vpc) | resource |
| [aws_iam_policy.vpc_cni](https://registry.terraform.io/providers/hashicorp/aws/5.71.0/docs/data-sources/iam_policy) | data source |
| [aws_iam_policy_document.cluster_autoscaler](https://registry.terraform.io/providers/hashicorp/aws/5.71.0/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.eks_cluster_assume_role](https://registry.terraform.io/providers/hashicorp/aws/5.71.0/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_roles.administrator](https://registry.terraform.io/providers/hashicorp/aws/5.71.0/docs/data-sources/iam_roles) | data source |
| [tls_certificate.eks](https://registry.terraform.io/providers/hashicorp/tls/4.0.6/docs/data-sources/certificate) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ami_id"></a> [ami\_id](#input\_ami\_id) | EKS ノードで使用する AMI ID を指定してください。 | `string` | `"ami-082334f38f661d103"` | no |
| <a name="input_eks_cluster_access_cidrs"></a> [eks\_cluster\_access\_cidrs](#input\_eks\_cluster\_access\_cidrs) | EKS クラスタの API Server にアクセス可能な CIDR ブロックを配列で指定してください。 | `list(string)` | n/a | yes |
| <a name="input_env"></a> [env](#input\_env) | 環境を識別する文字列を指定してください。 | `string` | n/a | yes |
| <a name="input_max_unavailable_percentage"></a> [max\_unavailable\_percentage](#input\_max\_unavailable\_percentage) | EKS ノードのアップデート時に許容する最大のアンアベイラビリティを指定してください。 | `number` | `10` | no |
| <a name="input_node_resources_business"></a> [node\_resources\_business](#input\_node\_resources\_business) | EKS ノード (business) のリソースを指定してください。 | <pre>object({<br/>    instance_type = string<br/>    min_size      = number<br/>    max_size      = number<br/>    desired_size  = number<br/>  })</pre> | <pre>{<br/>  "desired_size": 0,<br/>  "instance_type": "m7i-flex.large",<br/>  "max_size": 5,<br/>  "min_size": 0<br/>}</pre> | no |
| <a name="input_node_resources_system"></a> [node\_resources\_system](#input\_node\_resources\_system) | EKS ノード (system) のリソースを指定してください。 | <pre>object({<br/>    instance_type = string<br/>    min_size      = number<br/>    max_size      = number<br/>    desired_size  = number<br/>  })</pre> | <pre>{<br/>  "desired_size": 1,<br/>  "instance_type": "m7i-flex.large",<br/>  "max_size": 5,<br/>  "min_size": 0<br/>}</pre> | no |
| <a name="input_private_subnet_configs"></a> [private\_subnet\_configs](#input\_private\_subnet\_configs) | プライベートサブネットの CIDR ブロックを指定してください。 | <pre>list(object({<br/>    cidr_block = string<br/>    az         = string<br/>  }))</pre> | <pre>[<br/>  {<br/>    "az": "ap-northeast-1a",<br/>    "cidr_block": "172.16.2.0/23"<br/>  },<br/>  {<br/>    "az": "ap-northeast-1c",<br/>    "cidr_block": "172.16.4.0/23"<br/>  }<br/>]</pre> | no |
| <a name="input_public_subnet_configs"></a> [public\_subnet\_configs](#input\_public\_subnet\_configs) | パブリックサブネットの CIDR ブロックを指定してください。 | <pre>list(object({<br/>    cidr_block = string<br/>    az         = string<br/>  }))</pre> | <pre>[<br/>  {<br/>    "az": "ap-northeast-1a",<br/>    "cidr_block": "172.16.0.0/24"<br/>  },<br/>  {<br/>    "az": "ap-northeast-1c",<br/>    "cidr_block": "172.16.1.0/24"<br/>  }<br/>]</pre> | no |
| <a name="input_region"></a> [region](#input\_region) | リソースを作成する AWS のリージョンを指定してください。 | `string` | `"ap-northeast-1"` | no |
| <a name="input_vpc_cidr_block"></a> [vpc\_cidr\_block](#input\_vpc\_cidr\_block) | VPC の CIDR ブロックを指定してください。 | `string` | `"172.16.0.0/16"` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
