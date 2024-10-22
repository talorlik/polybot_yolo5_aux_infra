variable "env" {
  description = "Deployment environment"
  type        = string
}

variable "region" {
  description = "Deployment region"
  type        = string
  default     = "us-east-1"
}

variable "prefix" {
  description = "Name added to all resources"
  type        = string
}

variable "iam_role_policy_name" {
  type = string
  default = "wn-addon-policy"
}

variable "policy_template" {
  description = "IAM policy template file name with"
  type        = string
  default     = "policy_template.tftpl"
}

variable "s3_bucket_arn" {
  description = "ARN of the S3 bucket"
  type        = string
}

variable "dynamodb_table_arn" {
  description = "ARN of the DynamoDB table"
  type        = string
}

variable "identify_queue_arn" {
  description = "ARN of the Identify SQS queue"
  type        = string
}

variable "results_queue_arn" {
  description = "ARN of the Results SQS queue"
  type        = string
}

variable "tags" {
  type = map(string)
}