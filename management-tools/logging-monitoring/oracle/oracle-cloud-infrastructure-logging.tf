
    # Configure the Oracle Cloud Infrastructure Provider
provider "oci" {
  # Replace with your tenancy OCID
  tenancy_ocid = "ocid1.tenancy.oc1..aaaaaaaaxxxxxx"
  # Replace with your user OCID
  user_ocid = "ocid1.user.oc1..aaaaaaaaxxxxxx"
  # Replace with your region
  region = "us-ashburn-1"
  # Replace with your compartment OCID
  compartment_id = "ocid1.compartment.oc1..aaaaaaaaxxxxxx"
}

# Create a logging service
resource "oci_logging_service" "main" {
  name = "my-logging-service"
  # Optional: Create a custom compartment for logging resources
  compartment_id = oci_compartment.logging_compartment.id
}

# Create a log group
resource "oci_logging_log_group" "main" {
  # Replace with your logging service ID
  logging_service_id = oci_logging_service.main.id
  name = "my-log-group"
  # Set the type of log group
  log_group_type = "CUSTOM"
  # Optional: Set the retention policy for logs in days
  retention_in_days = 30
}

# Create a log group with a specific retention policy
resource "oci_logging_log_group" "with_retention_policy" {
  # Replace with your logging service ID
  logging_service_id = oci_logging_service.main.id
  name = "my-log-group-with-retention"
  # Set the type of log group
  log_group_type = "CUSTOM"
  # Set the retention policy for logs in days
  retention_in_days = 14
}

# Create a log source
resource "oci_logging_log_source" "main" {
  # Replace with your logging service ID
  logging_service_id = oci_logging_service.main.id
  # Replace with your log group ID
  log_group_id = oci_logging_log_group.main.id
  name = "my-log-source"
  # Optional: Set the description for the log source
  description = "This is my log source"
  # Define the log source type
  type = "OCI_RESOURCE"
  # Define the resource type to log
  resource_type = "INSTANCE"
  # Define the resource ID to log
  resource_id = "ocid1.instance.oc1..aaaaaaaaxxxxxx"
  # Optional: Define the logging configuration for the log source
  logging_config {
    # Define the log level to log
    log_level = "INFO"
  }
}

# Create a compartment for logging resources
resource "oci_compartment" "logging_compartment" {
  name = "logging-compartment"
  compartment_id = oci_compartment.main.id
  # Optional: Set the description for the compartment
  description = "Compartment for logging resources"
}

  