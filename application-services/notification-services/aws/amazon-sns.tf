
    # Configure the AWS Provider
provider "aws" {
  region = "us-east-1" # Replace with your desired AWS region
}

# Create an SNS Topic
resource "aws_sns_topic" "main" {
  name = "my-sns-topic"
  # Optional: Add tags to the topic
  tags = {
    Name = "My SNS Topic"
  }
}

# Create an SNS Subscription
resource "aws_sns_subscription" "main" {
  topic_arn = aws_sns_topic.main.arn
  protocol  = "email"
  endpoint = "your_email@example.com"
}

# Create an SNS Topic Policy
resource "aws_sns_topic_policy" "main" {
  topic_arn = aws_sns_topic.main.arn
  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Principal": {
          "AWS": "arn:aws:iam::123456789012:root"
        },
        "Action": [
          "sns:Publish",
          "sns:Receive"
        ],
        "Resource": aws_sns_topic.main.arn
      }
    ]
  })
}
  