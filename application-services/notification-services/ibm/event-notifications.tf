
    # Configure the IBM Cloud provider
provider "ibm" {
  region = "us-south"
}

# Create an Event Notifications instance
resource "ibm_event_notifications_instance" "main" {
  name = "my-event-notifications-instance"
  plan = "lite"
}

# Create an Event Notifications rule
resource "ibm_event_notifications_rule" "main" {
  instance_id = ibm_event_notifications_instance.main.id
  name = "my-event-notifications-rule"
  event_types = ["cloud-object-storage-events"]
  trigger = {
    # Configure the trigger for the rule
    actions = ["create"]
    bucket = "my-bucket"
    # Other trigger configuration options
  }
  # Define the actions to be performed when the rule is triggered
  actions {
    # Configure the action to send a notification to Slack
    slack {
      # Configure the Slack webhook URL
      webhook_url = "https://hooks.slack.com/services/T00000000/B00000000/XXXXXXXXXXXXXXXXXXXXXXXX"
      # Optional: Configure the channel to send the notification
      channel = "#my-channel"
    }
  }
}

  