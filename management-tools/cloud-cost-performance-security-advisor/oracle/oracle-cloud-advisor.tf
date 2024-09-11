
    # Configure the Oracle Cloud Provider
provider "oci" {
  region = "us-ashburn-1" # Replace with your preferred region
  tenancy = "ocid1.tenancy.oc1..."
  user    = "ocid1.user.oc1..."
  fingerprint = "..."
  key_file = "~/.oci/config" # Path to your OCI configuration file
}

# Create a Cloud Advisor Service
resource "oci_cloud_advisor_service" "main" {
  compartment_id = "ocid1.compartment.oc1..."
  name = "MyCloudAdvisorService"

  # Create a Cloud Advisor Assessment
  assessment {
    # Use a predefined Assessment Template
    template_id = "ocid1.cloudadvisortemplate.oc1..."
    
    # Optional: Provide a name for the assessment
    display_name = "MyAssessment"
  }
}

  