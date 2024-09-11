
    # Configure the Oracle Cloud provider
provider "oci" {
  # Replace with your tenancy ID, user OCID, and private key file.
  tenancy_id    = "ocid1.tenancy.oc1..."
  user_ocid     = "ocid1.user.oc1..."
  private_key_file = "~/.oci/oci_api_key.pem"
  region = "us-ashburn-1"
}

# Create an Oracle Logging Analytics namespace
resource "oci_logging_analytics_namespace" "main" {
  compartment_id = "ocid1.compartment.oc1..."
  display_name  = "my-logging-analytics-namespace"
}

# Create an Oracle Logging Analytics log group
resource "oci_logging_analytics_log_group" "main" {
  compartment_id = "ocid1.compartment.oc1..."
  namespace_id  = oci_logging_analytics_namespace.main.id
  display_name  = "my-log-group"
}

# Create an Oracle Logging Analytics log
resource "oci_logging_analytics_log" "main" {
  compartment_id = "ocid1.compartment.oc1..."
  namespace_id  = oci_logging_analytics_namespace.main.id
  log_group_id   = oci_logging_analytics_log_group.main.id
  display_name  = "my-log"
}

# Create an Oracle Logging Analytics log ingestion rule
resource "oci_logging_analytics_log_ingestion_rule" "main" {
  compartment_id = "ocid1.compartment.oc1..."
  namespace_id  = oci_logging_analytics_namespace.main.id
  log_group_id   = oci_logging_analytics_log_group.main.id
  log_id         = oci_logging_analytics_log.main.id
  display_name  = "my-log-ingestion-rule"
  # Configure the log ingestion rule to match specific log messages.
  ingestion_rule = "{\"key\": \"value\"}"
}

  