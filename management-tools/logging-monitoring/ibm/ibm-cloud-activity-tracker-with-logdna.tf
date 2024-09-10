
    # Configure the IBM Cloud Provider
provider "ibm" {
  region  = "us-south"
  account_id = "YOUR_IBM_ACCOUNT_ID"
  api_key    = "YOUR_IBM_API_KEY"
}

# Create a LogDNA Account
resource "ibm_logdna_account" "main" {
  name = "my-logdna-account"
  plan = "free"
}

# Create an Activity Tracker Instance
resource "ibm_activity_tracker_instance" "main" {
  name                  = "my-activity-tracker"
  logdna_account_id     = ibm_logdna_account.main.id
  activity_type         = "all"
  resource_group_id       = "YOUR_RESOURCE_GROUP_ID"
  resource_group_name     = "YOUR_RESOURCE_GROUP_NAME"
}

# Create an Activity Tracker Rule
resource "ibm_activity_tracker_rule" "main" {
  name                  = "my-activity-tracker-rule"
  activity_tracker_id = ibm_activity_tracker_instance.main.id
  activity_type         = "all"
  resource_group_id       = "YOUR_RESOURCE_GROUP_ID"
  resource_group_name     = "YOUR_RESOURCE_GROUP_NAME"
  # Use tags to filter activities
  tags = {
    "environment" = "dev"
  }
  # Define the rule's severity level
  severity_level      = "INFO"
  # Enable the rule
  enabled               = true
}

  