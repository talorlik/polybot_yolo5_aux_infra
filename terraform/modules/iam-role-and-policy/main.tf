# Get worker node EC2 Instace Info
data "aws_instances" "worker_nodes" {
  filter {
    name   = "tag:MachineRole"
    values = ["worker_node"]
  }
}

# Get the Instance Profile from the EC2 machine
data "aws_iam_instance_profile" "iam_instance_profile" {
  for_each = toset(data.aws_instances.worker_nodes.ids)

  name = data.aws_instances.worker_nodes.tags["aws:instance-profile"]
}

# Extract IAM Role from the instance profile
data "aws_iam_role" "iam_role" {
  for_each = toset(data.aws_instances.worker_nodes.ids)

  name = data.aws_iam_instance_profile.iam_instance_profile[each.key].roles[0]
}

locals {
  iam_role_policy_name      = "${var.prefix}-${var.region}-${var.iam_role_policy_name}-${var.env}"
  policy = templatefile("${path.module}/${var.policy_template}", {
    s3_bucket_arn              = var.s3_bucket_arn,
    dynamodb_table_arn         = var.dynamodb_table_arn,
    identify_queue_arn         = var.identify_queue_arn,
    results_queue_arn          = var.results_queue_arn
  })
}

resource "aws_iam_policy" "iam_role_policy" {
  name   = local.iam_role_policy_name
  policy = local.policy
}

resource "aws_iam_policy_attachment" "attach_policy_to_iam_role" {
  for_each = data.aws_iam_role.iam_role

  name       = "worker-node-policy-${each.key}"
  roles      = [each.value.name]
  policy_arn = aws_iam_policy.iam_create_secret_policy.arn
}