### General ###
env            = "prod"
prefix         = "talo-tf"
resource_alias = "talo"
### S3 ###
s3_bucket_name           = "s3"
s3_bucket_prefix         = "images"
acl                      = "private"
control_object_ownership = true
object_ownership         = "ObjectWriter"
versioning = {
  enabled = true
}
### Secrets ###
telegram_token_name = "telegram/token/v2b"
### SQS ###
identify_queue_name = "sqs-identify"
results_queue_name  = "sqs-results"
### DynamoDB ###
table_name     = "prediction-results"
billing_mode   = "PROVISIONED"
hash_key       = "predictionId"
read_capacity  = 1
write_capacity = 1
global_secondary_indexes = [
  {
    name            = "chatId-predictionId-index"
    hash_key        = "chatId"
    range_key       = "predictionId"
    read_capacity   = 1
    write_capacity  = 1
    projection_type = "ALL"
  },
  {
    name            = "another-index"
    hash_key        = "anotherKey"
    range_key       = "anotherRangeKey"
    read_capacity   = 1
    write_capacity  = 1
    projection_type = "ALL"
  }
]
attributes = [
  {
    name = "predictionId"
    type = "S"
  },
  {
    name = "chatId"
    type = "N"
  },
  {
    name = "anotherKey"
    type = "S"
  },
  {
    name = "anotherRangeKey"
    type = "N"
  }
]
