
    # Configure the Oracle Cloud Infrastructure provider
provider "oci" {
  # Replace with your OCI tenancy OCID
  tenancy_ocid = "ocid1.tenancy.oc1..aaaaaaaat7u7w66666666666666666666667"
  # Replace with your OCI user OCID
  user_ocid = "ocid1.user.oc1..aaaaaaaawz673666666666666666666666666"
  # Replace with your OCI private key path
  private_key_path = "~/.oci/oci_api_key.pem"
  # Replace with your OCI region
  region = "us-ashburn-1"
}

# Create an Oracle Functions application
resource "oci_functions_application" "main" {
  display_name = "my-functions-app"
  # Replace with your OCI compartment OCID
  compartment_id = "ocid1.compartment.oc1..aaaaaaaaz74q2666666666666666666666666"
}

# Create an Oracle Functions function
resource "oci_functions_function" "main" {
  display_name = "my-function"
  # Replace with the application OCID
  application_id = oci_functions_application.main.id
  # Replace with the function code
  source_code = "// Your function code here"
  # Replace with the function runtime
  runtime = "java11"
  # Define the function entry point
  handler = "com.example.MyFunction"
}

  