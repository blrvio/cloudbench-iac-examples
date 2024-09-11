
    # Configure the Oracle Cloud Infrastructure provider
provider "oci" {
  region = "us-ashburn-1" # Replace with your desired region
  # Configure authentication credentials
  # See https://www.terraform.io/docs/providers/oci/index.html#configuration for details
  config = {
    user_ocid  = "YOUR_OCID"
    tenancy_ocid = "YOUR_TENANCY_OCID"
    fingerprint = "YOUR_FINGERPRINT"
    private_key_path = "path/to/your/private/key"
  }
}

# Create a Visual Builder application
resource "oci_visual_builder_application" "main" {
  # Configure the application
  display_name = "My Visual Builder Application"
  # ...
}

# Create a Visual Builder component
resource "oci_visual_builder_component" "main" {
  # Configure the component
  display_name = "My Visual Builder Component"
  application_id = oci_visual_builder_application.main.id
  # ...
}

# Create a Visual Builder page
resource "oci_visual_builder_page" "main" {
  # Configure the page
  display_name = "My Visual Builder Page"
  application_id = oci_visual_builder_application.main.id
  # ...
}

# Create a Visual Builder service
resource "oci_visual_builder_service" "main" {
  # Configure the service
  display_name = "My Visual Builder Service"
  application_id = oci_visual_builder_application.main.id
  # ...
}
  