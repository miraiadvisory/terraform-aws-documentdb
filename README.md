## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Modules

No Modules.

## Resources

| Name |
|------|
| [aws_docdb_cluster](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/docdb_cluster) |
| [aws_docdb_cluster_instance](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/docdb_cluster_instance) |
| [aws_docdb_cluster_parameter_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/docdb_cluster_parameter_group) |
| [aws_docdb_subnet_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/docdb_subnet_group) |
| [aws_security_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| docdb\_familyversion | Version to launch on documentdb (MONGODB compatibility) | `string` | `"docdb3.6"` | no |
| docdb\_instanceNumber | Number of instances to launch within the cluster | `string` | `"1"` | no |
| docdb\_instanceType | Type of instance to launch into DocumentDB cluster | `string` | `"db.r5.large"` | no |
| docdb\_masterPassword | Password for DocumentDB admin | `string` | `"changeme"` | no |
| docdb\_port | Port where DocumentDB will be accesed | `string` | `"27017"` | no |
| docdb\_profilerEnable | Set mongodb profiler on/off | `string` | `"disabled"` | no |
| docdb\_storageEncrypted | Set DocumentDB storage encryption at rest | `string` | `"true"` | no |
| docdb\_tlsEnable | Set TLS communication to/from DocumentDB cluster | `string` | `"disabled"` | no |
| eb\_nodesSecuritygroup | The ID of the VPN server | `any` | n/a | yes |
| environment | n/a | `string` | n/a | yes |
| priv-subnet-1 | Private Subnet 1 ID | `string` | n/a | yes |
| priv-subnet-2 | Private Subnet 2 ID | `string` | n/a | yes |
| priv-subnet-3 | Private Subnet 3 ID | `string` | n/a | yes |
| projectname | n/a | `string` | n/a | yes |
| vpc | The ID of the VPC where will be created | `string` | n/a | yes |
| vpn\_sg | The ID of the VPN server | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| docdb\_host | n/a |
