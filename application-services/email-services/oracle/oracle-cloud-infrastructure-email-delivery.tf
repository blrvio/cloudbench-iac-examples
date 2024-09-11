
    # Configure the Oracle Cloud Infrastructure Provider
provider "oci" {
  region  = "us-ashburn-1"
  # Add your tenancy OCID and user OCID
  tenancy_ocid = "ocid1.tenancy.oc1..<your_tenancy_ocid>"
  user_ocid = "ocid1.user.oc1..<your_user_ocid>"
  # Authenticate using an API key
  # Add your API Key and Secret
  api_key_fingerprint = "<your_api_key_fingerprint>"
  api_key = "<your_api_key>"
}

# Create an Email Delivery service
resource "oci_email_delivery_service" "main" {
  # Configure the name of your service
  display_name = "My-Email-Service"
  # Configure the compartment ID
  compartment_id = "ocid1.compartment.oc1..<your_compartment_id>"
  # Configure the sender details
  sender_info {
    from_name = "My Email Name"
    from_email = "my.email@example.com"
  }
}

# Create an Email Delivery sender identity
resource "oci_email_delivery_sender_identity" "main" {
  # Configure the name of the sender identity
  display_name = "My Sender Identity"
  # Configure the compartment ID
  compartment_id = "ocid1.compartment.oc1..<your_compartment_id>"
  # Configure the email address
  email_address = "my.sender@example.com"
  # Configure the service OCID
  service_ocid = oci_email_delivery_service.main.id
}

# Create an Email Delivery sending domain
resource "oci_email_delivery_sending_domain" "main" {
  # Configure the name of the sending domain
  display_name = "My Sending Domain"
  # Configure the compartment ID
  compartment_id = "ocid1.compartment.oc1..<your_compartment_id>"
  # Configure the domain name
  domain_name = "example.com"
  # Configure the service OCID
  service_ocid = oci_email_delivery_service.main.id
}

  