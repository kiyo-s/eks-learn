<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.9.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | 5.71.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.71.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_kms_alias.sops](https://registry.terraform.io/providers/hashicorp/aws/5.71.0/docs/resources/kms_alias) | resource |
| [aws_kms_key.sops](https://registry.terraform.io/providers/hashicorp/aws/5.71.0/docs/resources/kms_key) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_env"></a> [env](#input\_env) | 環境を識別する文字列を指定してください。 | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | リソースを作成する AWS のリージョンを指定してください。 | `string` | `"ap-northeast-1"` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->