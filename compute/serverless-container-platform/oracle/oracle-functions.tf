
    # Configure the Oracle Cloud Infrastructure provider
provider "oci" {
  # Replace with your Oracle Cloud Infrastructure tenancy OCID
  tenancy_ocid = "ocid1.tenancy.oc1..aaaaaaaaw76z545672b5y5q5w5t3w5x74326" 
  # Replace with your Oracle Cloud Infrastructure user OCID
  user_ocid    = "ocid1.user.oc1..aaaaaaaaw76z545672b5y5q5w5t3w5x74326"
  # Replace with your Oracle Cloud Infrastructure region
  region        = "us-ashburn-1"
  # Replace with your Oracle Cloud Infrastructure compartment OCID
  compartment_ocid = "ocid1.compartment.oc1..aaaaaaaaw76z545672b5y5q5w5t3w5x74326"
}

# Define the Function resource
resource "oci_functions_function" "main" {
  # Replace with a unique name for your function
  name = "my-function"
  # Replace with the path to your function code
  code = "path/to/function/code"
  # Replace with the path to your function configuration
  config = "path/to/function/config"
  # Replace with the name of the function runtime
  runtime = "java11"
  # Replace with the version of the function
  version = "1.0.0"
  # Set to true to enable tracing for the function
  tracing_enabled = true
}

# Define the Function Trigger resource
resource "oci_functions_function_trigger" "main" {
  # Replace with the OCID of your Function
  function_id = oci_functions_function.main.id
  # Replace with the type of trigger (e.g., http, queue)
  trigger_type = "http"
  # Replace with the name of the trigger
  name = "my-trigger"
}

  