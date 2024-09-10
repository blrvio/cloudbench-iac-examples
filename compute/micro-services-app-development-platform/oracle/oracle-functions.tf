
    # Configure the Oracle Cloud Infrastructure provider
provider "oci" {
  # Replace with your OCI tenancy OCID
  tenancy_ocid = "ocid1.tenancy.oc1..aaaaaaaam777777777777777777777777777"
  # Replace with your OCI user OCID
  user_ocid    = "ocid1.user.oc1..aaaaaaaam777777777777777777777777777"
  # Replace with your OCI private key
  private_key  = "-----BEGIN PRIVATE KEY-----
...
-----END PRIVATE KEY-----"
  region       = "us-ashburn-1"
}

# Create a compartment
resource "oci_core_compartment" "example" {
  name    = "my-compartment"
  defined_tags = {
    "Environment" = "Development"
  }
  freeform_tags = {
    "Owner" = "Example User"
  }
}

# Create a function
resource "oci_functions_function" "example" {
  compartment_id = oci_core_compartment.example.id
  name           = "my-function"
  display_name  = "My Function"
  runtime        = "nodejs16"
  source_location = "oci://bucket/path/to/my-function.zip"
  description    = "This is my function"
}

# Create a function invocation
resource "oci_functions_function_invocation" "example" {
  function_id    = oci_functions_function.example.id
  payload        = "{\"message\": \"Hello, world!\"}"
  invoke_mode     = "sync"
  wait_for_completion = true
  timeout_in_seconds = 10
}

  