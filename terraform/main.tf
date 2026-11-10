terraform {
  required_version = ">= 1.5"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

provider "aws" {
  region = var.region

  default_tags {
    tags = {
      Project     = "stripe-fraud-detection"
      Environment = "demo"
      Owner       = var.owner
      ManagedBy   = "terraform"
    }
  }
}

# Création du datalake S3

resource "aws_s3_bucket" "datalake" {
  bucket_prefix = "stripe-fraud-datalake-"
  force_destroy = true #Pour forcer la destruction après le test

  tags = {
    Name      = "stripe-fraud-datalake"
    DataWorld = "data-lake"
  }
}

# Chiffrement KMS
resource "aws_s3_bucket_server_side_encryption_configuration" "datalake" {
  bucket = aws_s3_bucket.datalake.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "aws:kms"
    }
    bucket_key_enabled = true
  }
}

# Désactivation des accès publics
resource "aws_s3_bucket_public_access_block" "datalake" {
  bucket                  = aws_s3_bucket.datalake.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# Versioning
resource "aws_s3_bucket_versioning" "datalake" {
  bucket = aws_s3_bucket.datalake.id

  versioning_configuration {
    status = "Enabled"
  }
}

# Création de l'EC2 pour le scoring

data "aws_ssm_parameter" "amazon_linux" {
  name = "/aws/service/ami-amazon-linux-latest/al2023-ami-kernel-default-x86_64"
}

resource "aws_instance" "fraud_inference" {
  ami           = data.aws_ssm_parameter.amazon_linux.value
  instance_type = var.instance_type

  root_block_device {
    volume_type = "gp3"
    volume_size = 8
    encrypted   = true
  }

  metadata_options {
    http_tokens = "required"
  }

  tags = {
    Name    = "stripe-fraud-inference"
    Role    = "fraud-inference"
    Compute = "cpu"
  }
}
