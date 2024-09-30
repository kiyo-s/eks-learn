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

No providers.

## Modules

No modules.

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_env"></a> [env](#input\_env) | 環境を識別する文字列を指定してください。 | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | リソースを作成する AWS のリージョンを指定してください。 | `string` | `"ap-northeast-1"` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
