
    # Configure the AWS Provider
provider "aws" {
  region = "us-east-1" # Replace with your desired region
}

# Create an SQS Queue
resource "aws_sqs_queue" "main" {
  name = "my-sqs-queue" # Name of your SQS queue

  # Optional settings
  visibility_timeout = 300 # Visibility timeout in seconds
  max_message_size = 262144 # Maximum message size in bytes
  message_retention_period = 1209600 # Message retention period in seconds
  kms_data_key_reuse_period_seconds = 300 # KMS data key reuse period in seconds
  kms_master_key_id = "arn:aws:kms:us-east-1:123456789012:key/12345678-1234-1234-1234-123456789012" # KMS master key ID for encryption
  fifo_queue = false # Set to true to create a FIFO queue
  content_based_deduplication = false # Set to true to enable content-based deduplication
  redrive_policy = jsonencode({
    "deadLetterTargetArn": "arn:aws:sqs:us-east-1:123456789012:my-dead-letter-queue",
    "maxReceiveCount": 10
  }) # Configure the redrive policy (optional)
}

# Create an SQS Queue Policy (optional)
resource "aws_sqs_queue_policy" "main" {
  queue_url = aws_sqs_queue.main.id

  policy = jsonencode({
    "Version": "2012-10-17",
    "Id": "PolicyForSQSQueue",
    "Statement": [
      {
        "Sid": "AllowReadAccess",
        "Effect": "Allow",
        "Principal": {
          "AWS": "arn:aws:iam::123456789012:user/my-user"
        },
        "Action": [
          "sqs:ReceiveMessage",
          "sqs:DeleteMessage"
        ],
        "Resource": "arn:aws:sqs:us-east-1:123456789012:my-sqs-queue"
      }
    ]
  })
}
  