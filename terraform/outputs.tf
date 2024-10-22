output "region" {
  description = "The AWS region"
  value       = var.region
}

output "env" {
  description = "The Environment e.g. prod"
  value       = var.env
}

################### S3 ##########################

output "s3_bucket_name" {
  description = "The name of the S3 bucket"
  value       = local.s3_bucket_name
}

output "s3_bucket_arn" {
  description = "The ARN of the S3 bucket"
  value       = module.s3_bucket.s3_bucket_arn
}

output "s3_bucket_prefix" {
  description = "The folder name that where the images are"
  value       = var.s3_bucket_prefix
}

################### Secrets #####################

output "telegram_secret_name" {
  value = module.secret_telegram_token.secret_name
}

output "telegram_secret_arn" {
  value = module.secret_telegram_token.secret_arn
}

################## SQS #######################

output "identify_queue_name" {
  value = module.identify_queue.sqs_queue_name
}

output "identify_queue_arn" {
  value = module.identify_queue.sqs_queue_arn
}

output "results_queue_name" {
  value = module.results_queue.sqs_queue_name
}

output "results_queue_arn" {
  value = module.results_queue.sqs_queue_arn
}

############### DynamoDB ####################

output "table_name" {
  value = module.dynamodb.table_name
}

output "table_arn" {
  value = module.dynamodb.table_arn
}