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

###################### S3 ##########################

variable "s3_bucket_name" {
  description = "The name of the S3 bucket that holds the images"
  type        = string
}

variable "s3_bucket_prefix" {
  description = "The key (folder) to be used in the S3 bucket that holds the images"
  type        = string
}

variable "acl" {
  description = "Determine whether the S3 is private or public"
  type        = string
}

variable "control_object_ownership" {
  description = "Enable ownership over objects in the bucket or not"
  type        = bool
}

variable "object_ownership" {
  description = "Who owns that resources in the S3"
  type        = string
}

variable "versioning" {
  description = "Enable object versioning"
  type = object({
    enabled = bool
  })
}

################ Secrets ######################

variable "telegram_token_name" {
  description = "The name of the secret"
  type        = string
}

variable "telegram_token_value" {
  description = "The value of the secret"
  type        = string
  sensitive   = true
}

variable "domain_certificate_name" {
  description = "The name of the secret"
  type        = string
}

###################### SQS ##########################

variable "identify_queue_name" {
  description = "The name of the SQS Queue for identify"
  type        = string
}

variable "results_queue_name" {
  description = "The name of the SQS Queue for results"
  type        = string
}

################### DynamoDB ########################

variable "table_name" {
  description = "The name of the DynamoDB table"
  type        = string
}

variable "billing_mode" {
  description = "The billing mode of the DynamoDB table"
  type        = string
  default     = "PROVISIONED"
}

variable "hash_key" {
  description = "The hash key of the DynamoDB table"
  type        = string
}

variable "read_capacity" {
  description = "The read capacity units of the DynamoDB table"
  type        = number
  default     = 1
}

variable "write_capacity" {
  description = "The write capacity units of the DynamoDB table"
  type        = number
  default     = 1
}

variable "global_secondary_indexes" {
  description = "A list of global secondary indexes"
  type = list(object({
    name            = string
    hash_key        = string
    range_key       = string
    read_capacity   = number
    write_capacity  = number
    projection_type = string
  }))
}

variable "attributes" {
  description = "A list of attributes for the DynamoDB table"
  type = list(object({
    name = string
    type = string
  }))
}
