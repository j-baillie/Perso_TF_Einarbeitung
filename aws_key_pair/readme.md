<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_key_pair.jonpubkey](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/key_pair) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_jonpubkeyname"></a> [jonpubkeyname](#input\_jonpubkeyname) | Name to be given to keypair on ec2 instance | `string` | `"ConsistRechnerJonBaillie"` | no |
| <a name="input_jonpubkeypath"></a> [jonpubkeypath](#input\_jonpubkeypath) | Path to public key | `string` | `"DUMMY"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_jobpubkeypath"></a> [jobpubkeypath](#output\_jobpubkeypath) | n/a |
| <a name="output_jonpubkeyname"></a> [jonpubkeyname](#output\_jonpubkeyname) | n/a |
<!-- END_TF_DOCS -->