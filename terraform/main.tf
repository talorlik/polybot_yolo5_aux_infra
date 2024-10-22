data "aws_availability_zones" "available" {
  state = "available"
}

locals {
  s3_bucket_name = "${var.prefix}-${var.region}-${var.s3_bucket_name}-${var.env}"
  azs            = slice(data.aws_availability_zones.available.names, 0, 2)
  tags = {
    Env       = var.env
    Terraform = true
  }
}

module "s3_bucket" {
  source                   = "terraform-aws-modules/s3-bucket/aws"
  bucket                   = local.s3_bucket_name
  acl                      = var.acl
  control_object_ownership = var.control_object_ownership
  object_ownership         = var.object_ownership
  versioning               = var.versioning
  tags = merge(
    {
      Name = local.s3_bucket_name
    },
    local.tags
  )
}

################## Secrets ######################
module "secret_telegram_token" {
  source      = "./modules/secret-manager"
  env         = var.env
  region      = var.region
  prefix      = var.prefix
  secret_name = var.telegram_token_name
  secret_value = jsonencode({
    TELEGRAM_TOKEN = var.telegram_token_value
  })
  tags = local.tags
}

################ SQS Queues ####################
module "identify_queue" {
  source     = "./modules/sqs-queue"
  env        = var.env
  region     = var.region
  prefix     = var.prefix
  queue_name = var.identify_queue_name
  tags       = local.tags
}

module "results_queue" {
  source     = "./modules/sqs-queue"
  env        = var.env
  region     = var.region
  prefix     = var.prefix
  queue_name = var.results_queue_name
  tags       = local.tags
}

################ DynamoDB ####################

module "dynamodb" {
  source = "./modules/dynamodb"

  env                      = var.env
  region                   = var.region
  prefix                   = var.prefix
  table_name               = var.table_name
  billing_mode             = var.billing_mode
  hash_key                 = var.hash_key
  read_capacity            = var.read_capacity
  write_capacity           = var.write_capacity
  global_secondary_indexes = var.global_secondary_indexes
  attributes               = var.attributes
  tags                     = local.tags
}

################## IAM Role ######################

module "iam_role" {
  source = "./modules/iam-role-and-policy"

  env                = var.env
  region             = var.region
  prefix             = var.prefix

  s3_bucket_arn      = module.s3_bucket.s3_bucket_arn
  dynamodb_table_arn = module.dynamodb.table_arn
  identify_queue_arn = module.identify_queue.sqs_queue_arn
  results_queue_arn  = module.results_queue.sqs_queue_arn

  tags = local.tags
}