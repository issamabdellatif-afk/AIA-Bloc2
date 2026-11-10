output "bucket_name" {
  description = "Nom du bucket"
  value       = aws_s3_bucket.datalake.bucket
}

output "instance_id" {
  description = "ID de l'EC2"
  value       = aws_instance.fraud_inference.id
}

output "instance_tags" {
  description = "Étiquettes"
  value       = aws_instance.fraud_inference.tags_all
}
