
    # Configure the Oracle Cloud Infrastructure Provider
provider "oci" {
  region  = "us-ashburn-1"
  tenancy = "ocid1.tenancy.oc1..aaaaaaaaxxxxxxxxx"
  # Add your credentials
  user    = "your_user"
  password = "your_password"
}

# Create a Java Cloud Service Instance
resource "oci_java_cloud_service" "example" {
  compartment_id = "ocid1.compartment.oc1..aaaaaaaaxxxxxxxxx"
  display_name   = "MyJavaCloudService"
  # Add your desired shape, version, etc.
}

# (Optional) Create a Java Cloud Service Application
resource "oci_java_cloud_service_application" "example" {
  compartment_id = "ocid1.compartment.oc1..aaaaaaaaxxxxxxxxx"
  # Add your application details
  java_cloud_service_id = oci_java_cloud_service.example.id
}

# (Optional) Create a Java Cloud Service Database
resource "oci_java_cloud_service_database" "example" {
  compartment_id = "ocid1.compartment.oc1..aaaaaaaaxxxxxxxxx"
  # Add your database details
  java_cloud_service_id = oci_java_cloud_service.example.id
}
  