
    # Configure the Oracle Cloud Infrastructure provider
provider "oci" {
  region = "us-ashburn-1"
  # Replace with your region
  tenancy_ocid = "ocid1.tenancy.oc1..aaaaaaaaw7v4xrbq6b7k725h4g6p32xww3n6x47d3z52vbj6q5bqq"
  # Replace with your tenancy OCID
  user_ocid    = "ocid1.user.oc1..aaaaaaaay53ydx36rjj645i224724z5q47h7z37p45223e35w6d427h3"
  # Replace with your user OCID
  fingerprint   = "<YOUR_FINGERPRINT>"
  # Replace with your fingerprint
  private_key_path = "~/.oci/oci_api_key.pem"
  # Replace with the path to your private key
}

# Create a Security Advisor subscription
resource "oci_security_advisor_subscription" "main" {
  compartment_id = "ocid1.compartment.oc1..aaaaaaaayz53w436f67x6q4v224436z5p47g6p7x24m7k7w37b57g6p4"
  # Replace with your compartment OCID
  display_name = "My Security Advisor Subscription"
  # Define the configuration for the subscription
  config {
    # Enable alerts for critical issues
    critical_alerts_enabled = true
    # Set the severity level for notifications
    severity_level = "CRITICAL"
  }
}

  