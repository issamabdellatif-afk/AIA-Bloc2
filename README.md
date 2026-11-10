# Bloc 2 Certification AIA - Stripe — Issam Abdellatif

Publication du code Terraform pour le passage de la certification AIA Bloc 2.

Terraform permet d'assurer la reproductibilité, l'idempotence (sans doublons) et le versionning dans GIT.

Création d'un Bucket S3 (Data Lake des paiements pour l'entrainement ML) et d'une instance EC2 (pour le scoring des transactions).

Paramètres : Région Paris, chiffrement avec KMS, aucun accès public, étiquettes des ressources et EC2 minimal pour l'offre gratuite.

```
terraform/
  main.tf        description des ressources (bucket S3 et instance EC2)
  variables.tf   région, type d'instance, propriétaire
  outputs.tf     ce que Terraform affiche à la fin
```
Vidéo transmise en ZIP via Jedha Julie


Sortie du plan terraform :
```
data.aws_ssm_parameter.amazon_linux: Reading...
data.aws_ssm_parameter.amazon_linux: Read complete after 0s [id=/aws/service/ami-amazon-linux-latest/al2023-ami-kernel-default-x86_64]

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the
following symbols:
  + create

Terraform will perform the following actions:

  # aws_instance.fraud_inference will be created
  + resource "aws_instance" "fraud_inference" {
      + ami                                  = (sensitive value)
      + arn                                  = (known after apply)
      + associate_public_ip_address          = (known after apply)
      + availability_zone                    = (known after apply)
      + disable_api_stop                     = (known after apply)
      + disable_api_termination              = (known after apply)
      + ebs_optimized                        = (known after apply)
      + enable_primary_ipv6                  = (known after apply)
      + force_destroy                        = false
      + get_password_data                    = false
      + host_id                              = (known after apply)
      + host_resource_group_arn              = (known after apply)
      + iam_instance_profile                 = (known after apply)
      + id                                   = (known after apply)
      + instance_initiated_shutdown_behavior = (known after apply)
      + instance_lifecycle                   = (known after apply)
      + instance_state                       = (known after apply)
      + instance_type                        = "t3.micro"
      + ipv6_address_count                   = (known after apply)
      + ipv6_addresses                       = (known after apply)
      + key_name                             = (known after apply)
      + monitoring                           = (known after apply)
      + outpost_arn                          = (known after apply)
      + password_data                        = (known after apply)
      + placement_group                      = (known after apply)
      + placement_group_id                   = (known after apply)
      + placement_partition_number           = (known after apply)
      + primary_network_interface_id         = (known after apply)
      + private_dns                          = (known after apply)
      + private_ip                           = (known after apply)
      + public_dns                           = (known after apply)
      + public_ip                            = (known after apply)
      + region                               = "eu-west-3"
      + secondary_private_ips                = (known after apply)
      + security_groups                      = (known after apply)
      + source_dest_check                    = true
      + spot_instance_request_id             = (known after apply)
      + subnet_id                            = (known after apply)
      + tags                                 = {
          + "Compute" = "cpu"
          + "Name"    = "stripe-fraud-inference"
          + "Role"    = "fraud-inference"
        }
      + tags_all                             = {
          + "Compute"     = "cpu"
          + "Environment" = "demo"
          + "ManagedBy"   = "terraform"
          + "Name"        = "stripe-fraud-inference"
          + "Owner"       = "issam-abdellatif"
          + "Project"     = "stripe-fraud-detection"
          + "Role"        = "fraud-inference"
        }
      + tenancy                              = (known after apply)
      + user_data_base64                     = (known after apply)
      + user_data_replace_on_change          = false
      + vpc_security_group_ids               = (known after apply)

      + capacity_reservation_specification (known after apply)

      + cpu_options (known after apply)

      + ebs_block_device (known after apply)

      + enclave_options (known after apply)

      + ephemeral_block_device (known after apply)

      + instance_market_options (known after apply)

      + maintenance_options (known after apply)

      + metadata_options {
          + http_endpoint               = "enabled"
          + http_protocol_ipv6          = "disabled"
          + http_put_response_hop_limit = (known after apply)
          + http_tokens                 = "required"
          + instance_metadata_tags      = (known after apply)
        }

      + network_interface (known after apply)

      + primary_network_interface (known after apply)

      + private_dns_name_options (known after apply)

      + root_block_device {
          + delete_on_termination = true
          + device_name           = (known after apply)
          + encrypted             = true
          + iops                  = (known after apply)
          + kms_key_id            = (known after apply)
          + tags_all              = (known after apply)
          + throughput            = (known after apply)
          + volume_id             = (known after apply)
          + volume_size           = 8
          + volume_type           = "gp3"
        }

      + secondary_network_interface (known after apply)
    }

  # aws_s3_bucket.datalake will be created
  + resource "aws_s3_bucket" "datalake" {
      + acceleration_status         = (known after apply)
      + acl                         = (known after apply)
      + arn                         = (known after apply)
      + bucket                      = (known after apply)
      + bucket_domain_name          = (known after apply)
      + bucket_namespace            = (known after apply)
      + bucket_prefix               = "stripe-fraud-datalake-"
      + bucket_region               = (known after apply)
      + bucket_regional_domain_name = (known after apply)
      + force_destroy               = true
      + hosted_zone_id              = (known after apply)
      + id                          = (known after apply)
      + object_lock_enabled         = (known after apply)
      + policy                      = (known after apply)
      + region                      = "eu-west-3"
      + request_payer               = (known after apply)
      + tags                        = {
          + "DataWorld" = "data-lake"
          + "Name"      = "stripe-fraud-datalake"
        }
      + tags_all                    = {
          + "DataWorld"   = "data-lake"
          + "Environment" = "demo"
          + "ManagedBy"   = "terraform"
          + "Name"        = "stripe-fraud-datalake"
          + "Owner"       = "issam-abdellatif"
          + "Project"     = "stripe-fraud-detection"
        }
      + website_domain              = (known after apply)
      + website_endpoint            = (known after apply)

      + cors_rule (known after apply)

      + grant (known after apply)

      + lifecycle_rule (known after apply)

      + logging (known after apply)

      + object_lock_configuration (known after apply)

      + replication_configuration (known after apply)

      + server_side_encryption_configuration (known after apply)

      + versioning (known after apply)

      + website (known after apply)
    }

  # aws_s3_bucket_public_access_block.datalake will be created
  + resource "aws_s3_bucket_public_access_block" "datalake" {
      + block_public_acls       = true
      + block_public_policy     = true
      + bucket                  = (known after apply)
      + id                      = (known after apply)
      + ignore_public_acls      = true
      + region                  = "eu-west-3"
      + restrict_public_buckets = true
    }

  # aws_s3_bucket_server_side_encryption_configuration.datalake will be created
  + resource "aws_s3_bucket_server_side_encryption_configuration" "datalake" {
      + bucket = (known after apply)
      + id     = (known after apply)
      + region = "eu-west-3"

      + rule {
          + blocked_encryption_types = (known after apply)
          + bucket_key_enabled       = true

          + apply_server_side_encryption_by_default {
              + kms_master_key_id = (known after apply)
              + sse_algorithm     = "aws:kms"
            }
        }
    }

  # aws_s3_bucket_versioning.datalake will be created
  + resource "aws_s3_bucket_versioning" "datalake" {
      + bucket = (known after apply)
      + id     = (known after apply)
      + region = "eu-west-3"

      + versioning_configuration {
          + mfa_delete = (known after apply)
          + status     = "Enabled"
        }
    }

Plan: 5 to add, 0 to change, 0 to destroy.

Changes to Outputs:
  + bucket_name   = (known after apply)
  + instance_id   = (known after apply)
  + instance_tags = {
      + Compute     = "cpu"
      + Environment = "demo"
      + ManagedBy   = "terraform"
      + Name        = "stripe-fraud-inference"
      + Owner       = "issam-abdellatif"
      + Project     = "stripe-fraud-detection"
      + Role        = "fraud-inference"
    }
```
───────────────────────────────────────────────────────────────────────────────────────────────────────────────────────


Idempotence : 
```
terraform apply
data.aws_ssm_parameter.amazon_linux: Reading...
aws_s3_bucket.datalake: Refreshing state... [id=stripe-fraud-datalake-b6192f1e1b8f100766968547a1]
data.aws_ssm_parameter.amazon_linux: Read complete after 0s [id=/aws/service/ami-amazon-linux-latest/al2023-ami-kernel-default-x86_64]
aws_instance.fraud_inference: Refreshing state... [id=i-0075a132bf07b1c8e]
aws_s3_bucket_public_access_block.datalake: Refreshing state... [id=stripe-fraud-datalake-b6192f1e1b8f100766968547a1]
aws_s3_bucket_versioning.datalake: Refreshing state... [id=stripe-fraud-datalake-b6192f1e1b8f100766968547a1]
aws_s3_bucket_server_side_encryption_configuration.datalake: Refreshing state... [id=stripe-fraud-datalake-b6192f1e1b8f100766968547a1]

No changes. Your infrastructure matches the configuration.

Terraform has compared your real infrastructure against your configuration and found no differences, so no changes are
needed.

Apply complete! Resources: 0 added, 0 changed, 0 destroyed.

Outputs:

bucket_name = "stripe-fraud-datalake-b6192f1e1b8f100766968547a1"
instance_id = "i-0075a132bf07b1c8e"
instance_tags = tomap({
  "Compute" = "cpu"
  "Environment" = "demo"
  "ManagedBy" = "terraform"
  "Name" = "stripe-fraud-inference"
  "Owner" = "issam-abdellatif"
  "Project" = "stripe-fraud-detection"
  "Role" = "fraud-inference"
})
```
