
    # Configure the Oracle Cloud Infrastructure Provider
provider "oci" {
  region = "us-ashburn-1"
  # You will need to configure your authentication credentials for OCI
  # See: https://www.terraform.io/docs/providers/oci/index.html
}

# Create a Data Visualization Cloud Service Instance
resource "oci_data_visualization_instance" "main" {
  # Name of the instance
  display_name = "my-data-visualization-instance"

  # Choose the compartment OCID where the instance should be created
  compartment_id = "ocid1.compartment.oc1..aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"

  # Specify the type of service (Standard or Dedicated)
  service_type = "STANDARD"

  # Configure networking options (this is just an example)
  # You may need to adjust based on your specific requirements
  subnet_id = "ocid1.subnet.oc1..aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
  #...
}

# Create a Data Visualization Cloud Service User
resource "oci_data_visualization_user" "main" {
  # Name of the user
  display_name = "my-data-visualization-user"

  # Choose the compartment OCID where the user should be created
  compartment_id = "ocid1.compartment.oc1..aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"

  # Associate the user with the created instance
  instance_id = oci_data_visualization_instance.main.id
}

# Create a Data Visualization Cloud Service Group
resource "oci_data_visualization_group" "main" {
  # Name of the group
  display_name = "my-data-visualization-group"

  # Choose the compartment OCID where the group should be created
  compartment_id = "ocid1.compartment.oc1..aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
}

# Add the user to the group
resource "oci_data_visualization_group_assignment" "main" {
  group_id = oci_data_visualization_group.main.id
  user_id = oci_data_visualization_user.main.id
}

  