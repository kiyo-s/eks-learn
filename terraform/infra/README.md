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
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.69.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_eip.nat_gateway](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip) | resource |
| [aws_internet_gateway.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway) | resource |
| [aws_nat_gateway.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/nat_gateway) | resource |
| [aws_route.public_internet_gateway](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route_table.public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table_association.public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_subnet.public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_vpc.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_env"></a> [env](#input\_env) | 環境を識別する文字列を指定してください。 | `string` | n/a | yes |
| <a name="input_public_subnet_configs"></a> [public\_subnet\_configs](#input\_public\_subnet\_configs) | パブリックサブネットの CIDR ブロックを指定してください。 | <pre>list(object({<br/>    cidr_block = string<br/>    az         = string<br/>  }))</pre> | <pre>[<br/>  {<br/>    "az": "ap-northeast-1a",<br/>    "cidr_block": "172.16.0.0/24"<br/>  },<br/>  {<br/>    "az": "ap-northeast-1c",<br/>    "cidr_block": "172.16.1.0/24"<br/>  }<br/>]</pre> | no |
| <a name="input_region"></a> [region](#input\_region) | リソースを作成する AWS のリージョンを指定してください。 | `string` | `"ap-northeast-1"` | no |
| <a name="input_vpc_cidr_block"></a> [vpc\_cidr\_block](#input\_vpc\_cidr\_block) | VPC の CIDR ブロックを指定してください。 | `string` | `"172.16.0.0/16"` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
