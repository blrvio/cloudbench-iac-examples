
    # Configure the AWS provider
provider "aws" {
  region = "us-east-1" # Replace with your desired region
}

# Create a Pinpoint application
resource "aws_pinpoint_app" "main" {
  name = "my-pinpoint-app" # Name of your Pinpoint application

  # Optional settings
  application_settings {
    # Configure the default channel settings for the application
    default_push_notification_channel {
      # Disable push notifications by default
      enable_push_notification_channel = false
    }
    default_sms_channel {
      # Disable SMS notifications by default
      enable_sms_channel = false
    }
  }
}

# Create a segment in your Pinpoint application
resource "aws_pinpoint_segment" "main" {
  application_id = aws_pinpoint_app.main.id # ID of the Pinpoint application
  name            = "my-segment" # Name of the segment

  # Define the segment criteria
  dimensions {
    # Define the conditions for the segment
    # This example defines a segment for users who are in the US
    # and have a specific attribute set to 'value'
    # Replace with your own criteria
    # See the documentation for more options: https://docs.aws.amazon.com/pinpoint/latest/developerguide/apps-segments.html
    attributes {
      app_version {
        # Define a condition for the app version attribute
        # This example matches users with app version 1.0
        # Replace with your own condition
        dimension_type = "INCLUSIVE"
        values = ["1.0"]
      }
      # Define additional attributes and conditions as needed
    }
    location {
      # Define a condition for the user's location
      # This example matches users who are in the United States
      # Replace with your own condition
      country = "US"
    }
  }
}

# Create a campaign in your Pinpoint application
resource "aws_pinpoint_campaign" "main" {
  application_id = aws_pinpoint_app.main.id # ID of the Pinpoint application
  name            = "my-campaign" # Name of the campaign
  # Define the campaign settings
  schedule {
    # Configure the campaign schedule
    # This example sets the campaign to run immediately
    # Replace with your own schedule settings
    schedule_type = "NOW"
  }
  # Define the campaign message settings
  message_config {
    # Configure the message content
    # This example sends a push notification message
    # Replace with your own message settings
    # See the documentation for more options: https://docs.aws.amazon.com/pinpoint/latest/developerguide/apps-campaigns.html
    push {
      # Set the push message title and body
      # Replace with your own values
      body = "Welcome to my app!"
      title = "Welcome"
    }
  }
  # Configure the segment for the campaign
  segment_id = aws_pinpoint_segment.main.id # ID of the segment
}

  