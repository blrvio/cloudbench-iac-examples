
    # Configure the AWS provider
provider "aws" {
  region = "us-east-1" # Replace with your desired region
}

# Create a Kinesis stream
resource "aws_kinesis_stream" "main" {
  name            = "my-kinesis-stream"
  shard_count     = 1
  retention_period = 24 * 60 * 60 # 24 hours
  # Optional: Enable enhanced monitoring
  #  enhanced_monitoring = ["metrics", "logs"]

  # Optional: Set the stream's encryption configuration
  # encryption_type = "KMS"
  #  kms_key_id = "arn:aws:kms:us-east-1:123456789012:key/12345678-1234-1234-1234-123456789012"
}

# Create a Kinesis stream consumer
resource "aws_kinesis_stream_consumer" "main" {
  stream_arn = aws_kinesis_stream.main.arn
  name       = "my-stream-consumer"
}

# Create a Kinesis firehose delivery stream
# resource "aws_kinesis_firehose_delivery_stream" "main" {
#  name = "my-firehose-delivery-stream"
#  destination = "s3"
#  s3_configuration {
#    role_arn = aws_iam_role.main.arn
#    bucket_arn = "arn:aws:s3:::my-bucket"
#    prefix = "kinesis/data"
#  }
#}

# Create an IAM role for the firehose delivery stream
# resource "aws_iam_role" "main" {
#  name = "firehose-role"
#  assume_role_policy = <<EOF
# {
#   "Version": "2012-10-17",
#   "Statement": [
#     {
#       "Effect": "Allow",
#       "Principal": {
#         "Service": "firehose.amazonaws.com"
#       },
#       "Action": "sts:AssumeRole"
#     }
#   ]
# }
# EOF
#}

# Create an IAM policy for the firehose delivery stream
# resource "aws_iam_policy" "main" {
#  name = "firehose-policy"
#  policy = <<EOF
# {
#   "Version": "2012-10-17",
#   "Statement": [
#     {
#       "Effect": "Allow",
#       "Action": [
#         "s3:PutObject",
#         "s3:AbortMultipartUpload",
#         "s3:ListBucket"
#       ],
#       "Resource": [
#         "arn:aws:s3:::my-bucket",
#         "arn:aws:s3:::my-bucket/*"
#       ]
#     }
#   ]
# }
# EOF
#}

# Attach the IAM policy to the IAM role
# resource "aws_iam_role_policy_attachment" "main" {
#  role = aws_iam_role.main.name
#  policy_arn = aws_iam_policy.main.arn
#}

  