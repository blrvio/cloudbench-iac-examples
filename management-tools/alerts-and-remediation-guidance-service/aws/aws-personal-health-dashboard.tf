
# Configure the AWS Provider
provider "aws" {
  region = "us-east-1" # Replace with your desired AWS region
}

# Create a Personal Health Dashboard Event Subscription
resource "aws_personal_health_dashboard_event_subscription" "main" {
  # Define the event type you want to subscribe to
  event_type = "ISSUE"
  # Define the SNS topic to send notifications
  sns_topic_arn = aws_sns_topic.main.arn
}

# Create an SNS Topic for receiving notifications
resource "aws_sns_topic" "main" {
  name = "personal-health-dashboard-notifications"
}

  