
    # Configure the Huawei Cloud provider
provider "huaweicloud" {
  region = "cn-north-1" # Replace with your desired region
}

# Create a ServiceStage application
resource "huaweicloud_servicestage_app" "main" {
  app_name = "my-servicestage-app" # Name of your ServiceStage application
  # Optional settings
  description = "My ServiceStage application"
  # Define the environment of the application
  environment {
    # Define notification settings
    notification_config {
      # Configure Slack notification parameters
      slack {
        channel = "my-slack-channel" # Name of the Slack channel
        webhook_url = "https://hooks.slack.com/services/..." # URL of the Slack webhook
      }
    }
  }
}

# Create a ServiceStage service
resource "huaweicloud_servicestage_service" "main" {
  app_id = huaweicloud_servicestage_app.main.id # ID of the ServiceStage application
  name = "my-servicestage-service" # Name of the ServiceStage service
  # Optional settings
  description = "My ServiceStage service"
  # Define the environment of the service
  environment {
    # Define notification settings
    notification_config {
      # Configure Slack notification parameters
      slack {
        channel = "my-slack-channel" # Name of the Slack channel
        webhook_url = "https://hooks.slack.com/services/..." # URL of the Slack webhook
      }
    }
  }
}

# Create a ServiceStage API
resource "huaweicloud_servicestage_api" "main" {
  app_id = huaweicloud_servicestage_app.main.id # ID of the ServiceStage application
  service_id = huaweicloud_servicestage_service.main.id # ID of the ServiceStage service
  name = "my-servicestage-api" # Name of the ServiceStage API
  # Optional settings
  description = "My ServiceStage API"
  # Define the environment of the API
  environment {
    # Define notification settings
    notification_config {
      # Configure Slack notification parameters
      slack {
        channel = "my-slack-channel" # Name of the Slack channel
        webhook_url = "https://hooks.slack.com/services/..." # URL of the Slack webhook
      }
    }
  }
}

  