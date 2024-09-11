
    # Configure the Oracle Cloud provider
provider "oci" {
  region = "us-ashburn-1"
  # Replace with your Oracle Cloud region
  tenancy_ocid = "ocid1.tenancy.oc1..aaaaaaaatxxxxxxxxxxxxxxxx"
  # Replace with your tenancy OCID
  user_ocid = "ocid1.user.oc1..aaaaaaaatxxxxxxxxxxxxxxxx"
  # Replace with your user OCID
  fingerprint = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
  # Replace with your fingerprint
  private_key_path = "~/.oci/oci_api_key.pem"
  # Replace with the path to your private key
}

# Create a new queue
resource "oci_messaging_queue" "main" {
  compartment_id = "ocid1.compartment.oc1..aaaaaaaatxxxxxxxxxxxxxxxx"
  # Replace with your compartment OCID
  name = "my-queue"
  # Replace with your desired queue name
  config {
    # Optional configuration
    # You can adjust the queue's capacity and other settings here
  }
}

# Create a new topic
resource "oci_messaging_topic" "main" {
  compartment_id = "ocid1.compartment.oc1..aaaaaaaatxxxxxxxxxxxxxxxx"
  # Replace with your compartment OCID
  name = "my-topic"
  # Replace with your desired topic name
  config {
    # Optional configuration
    # You can adjust the topic's capacity and other settings here
  }
}

  