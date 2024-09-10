
# Configure the AWS Provider
provider "aws" {
  region = "us-east-1" # Replace with your desired region
}

# Create a Mobile Hub project
resource "aws_mobile_project" "main" {
  name = "my-mobile-project"
  # Create the project in the given region
  region = "us-east-1"
}

# Create a Mobile Hub backend
resource "aws_mobile_backend" "main" {
  app_id       = aws_mobile_project.main.id
  name         = "my-mobile-backend"
  backend_type = "REST"
}

# Create a Mobile Hub API
resource "aws_mobile_api" "main" {
  app_id     = aws_mobile_project.main.id
  name       = "my-mobile-api"
  backend_id = aws_mobile_backend.main.id
}

# Create a Mobile Hub data store
resource "aws_mobile_datastore" "main" {
  app_id         = aws_mobile_project.main.id
  name           = "my-mobile-datastore"
  backend_id     = aws_mobile_backend.main.id
  datastore_type = "AWS_PINPOINT"
}

# Create a Mobile Hub user pool
resource "aws_mobile_user_pool" "main" {
  app_id         = aws_mobile_project.main.id
  name           = "my-mobile-user-pool"
  backend_id     = aws_mobile_backend.main.id
  user_pool_type = "AWS_COGNITO"
}

# Create a Mobile Hub analytics configuration
resource "aws_mobile_analytics_config" "main" {
  app_id     = aws_mobile_project.main.id
  backend_id = aws_mobile_backend.main.id
}

# Create a Mobile Hub push notification configuration
resource "aws_mobile_push_notification_config" "main" {
  app_id        = aws_mobile_project.main.id
  backend_id    = aws_mobile_backend.main.id
  push_platform = "ANDROID"
}

# Create a Mobile Hub bot configuration
resource "aws_mobile_bot_config" "main" {
  app_id     = aws_mobile_project.main.id
  backend_id = aws_mobile_backend.main.id
  bot_type   = "LEX"
}

  