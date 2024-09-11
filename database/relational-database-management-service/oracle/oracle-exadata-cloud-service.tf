
    # Configure the Oracle Cloud Infrastructure provider
provider "oci" {
  region  = "us-ashburn-1"
  tenancy = "ocid1.tenancy.oc1..aaaaaaaaw7654321"
}

# Create an Exadata Cloud Service instance
resource "oci_exadata_cloud_service_instance" "main" {
  compartment_id       = "ocid1.compartment.oc1..aaaaaaaaw7654321"
  display_name        = "my-exadata-instance"
  shape                = "Exadata_X8_2448_M"
  subnet_id             = "ocid1.subnet.oc1..aaaaaaaaw7654321"
  exadata_cloud_service = "ocid1.exadata-cloud-service.oc1..aaaaaaaaw7654321"

  # Define the storage configuration
  storage_config {
    capacity_gb = 1000
    storage_type = "Standard"
  }
}

# Create a security list
resource "oci_network_security_list" "main" {
  compartment_id = "ocid1.compartment.oc1..aaaaaaaaw7654321"
  display_name    = "my-security-list"
  ingress {
    source    = "0.0.0.0/0"
    protocol  = "tcp"
    tcp_options {
      max = 80
      min = 80
    }
  }
  egress {
    destination = "0.0.0.0/0"
    protocol  = "all"
  }
}

# Attach the security list to the Exadata Cloud Service instance
resource "oci_exadata_cloud_service_instance_network_configuration" "main" {
  compartment_id = "ocid1.compartment.oc1..aaaaaaaaw7654321"
  exadata_cloud_service_instance_id = oci_exadata_cloud_service_instance.main.id
  security_list_id = oci_network_security_list.main.id
}

  