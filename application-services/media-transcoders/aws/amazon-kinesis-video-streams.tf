
    # Configure the AWS Provider
provider "aws" {
  region = "us-east-1" # Replace with your desired region
}

# Create a Kinesis Video Stream
resource "aws_kinesis_video_stream" "main" {
  name = "my-kinesis-video-stream"
  # Data retention in hours
  data_retention_in_hours = 168
  # The number of shards
  # You can choose between 1 and 10 shards.
  # The default is 1
  # A shard is a logical partition of a stream.
  # The more shards you have, the more throughput
  # you can have for your stream.
  # For more info on shards, see:
  # https://docs.aws.amazon.com/kinesisvideostreams/latest/dg/producer-guide.html
  # shards are a trade off between capacity and cost
  # More shards means higher cost and higher throughput.
  shard_count = 1
  # Enable server-side encryption
  # The key will be managed by KMS
  # The default is to not enable encryption.
  # This is a good practice to protect your data.
  # Make sure to use a strong key.
  # This can be done with the following code
  # 
  # resource "aws_kms_key" "main" {
  #   description             = "Kinesis Video Stream Encryption Key"
  #   enable_key_rotation     = true
  #   key_usage              = "ENCRYPT_DECRYPT"
  #   deletion_window_in_days = 7
  #   policy = <<EOF
  # {
  #   "Version": "2012-10-17",
  #   "Statement": [
  #     {
  #       "Effect": "Allow",
  #       "Principal": {
  #         "AWS": "arn:aws:iam::123456789012:root"
  #       },
  #       "Action": [
  #         "kms:DescribeKey",
  #         "kms:GetPublicKey",
  #         "kms:GetKeyPolicy",
  #         "kms:GetKeyRotationStatus",
  #         "kms:ListKeyPolicies",
  #         "kms:ListGrants",
  #         "kms:DescribeKey",
  #         "kms:Encrypt",
  #         "kms:Decrypt",
  #         "kms:GenerateDataKey",
  #         "kms:GenerateDataKeyWithoutPlaintext",
  #         "kms:ReEncryptFromDataKey",
  #         "kms:ReEncryptToDataKey",
  #         "kms:DescribeKey"
  #       ],
  #       "Resource": "*"
  #     },
  #     {
  #       "Effect": "Allow",
  #       "Principal": {
  #         "Service": "kinesisvideo.amazonaws.com"
  #       },
  #       "Action": [
  #         "kms:DescribeKey",
  #         "kms:GetPublicKey",
  #         "kms:Encrypt",
  #         "kms:Decrypt"
  #       ],
  #       "Resource": "*"
  #     }
  #   ]
  # }
  # EOF
  # }
  # 
  # You can also use an existing key from KMS.
  # For more info, see:
  # https://docs.aws.amazon.com/kms/latest/developerguide/concepts.html
  # encryption_type = "KMS"
  # key_id = aws_kms_key.main.key_id
  # Tag the Kinesis Video Stream
  tags = {
    Name = "My Kinesis Video Stream"
  }
}

# Create a Kinesis Video Stream Signaling Channel
# The signaling channel enables two-way communication
# between the producer and the consumer of the stream.
# This is useful for applications that require low latency.
resource "aws_kinesis_video_stream_signaling_channel" "main" {
  # The name of the Kinesis Video Stream to associate the signaling channel with.
  stream_name = aws_kinesis_video_stream.main.name
  # The name of the signaling channel
  name = "my-signaling-channel"
  # Tag the signaling channel
  tags = {
    Name = "My Signaling Channel"
  }
}

  