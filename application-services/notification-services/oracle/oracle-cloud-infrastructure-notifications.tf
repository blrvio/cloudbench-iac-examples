
    # Configure the Oracle Cloud Infrastructure Provider
provider "oci" {
  region = "us-ashburn-1"
  # Add your tenancy OCID, user OCID and private key here
  tenancy_ocid     = "ocid1.tenancy.oc1..aaaaaaaaxxxxxx"
  user_ocid       = "ocid1.user.oc1..aaaaaaaaxxxxxx"
  fingerprint = "xxxxxx"
  private_key_path = "~/.oci/oci_api_key.pem"
}

# Create a notification topic
resource "oci_notifications_topic" "example" {
  compartment_id = "ocid1.compartment.oc1..aaaaaaaaxxxxxx"
  name            = "example-topic"
  description     = "Example notification topic"
}

# Create a notification rule
resource "oci_notifications_rule" "example" {
  compartment_id = "ocid1.compartment.oc1..aaaaaaaaxxxxxx"
  topic_id       = oci_notifications_topic.example.id
  name            = "example-rule"
  description     = "Example notification rule"
  # Set the action to send an email
  actions = ["email"]
  # Set the email address for the notification
  email_addresses = ["example@example.com"]
  # Define the rule's condition
  condition {
    attribute = "instance.state"
    operation  = "EQUALS"
    value      = "RUNNING"
  }
}

  