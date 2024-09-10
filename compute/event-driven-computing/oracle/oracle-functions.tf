
    # Configure the Oracle Cloud provider
provider "oci" {
  # Set the region and compartment
  region     = "us-ashburn-1"
  compartment = "ocid1.compartment.oc1..aaaaaaaax777777777777777777777777"
}

# Define the Function
resource "oci_functions_function" "main" {
  # Define the function name
  name = "my-function"
  # Define the function description
  description = "My function description"
  # Specify the function runtime
  runtime = "java11"
  # Define the function code
  # The code is stored in a separate file
  code = file("path/to/your/function/code.zip")
  # Define the function environment variables
  environment_variables = {
    # Example environment variable
    "MY_ENV_VAR" = "my-env-var-value"
  }
  # Define the function triggers
  # Currently, only HTTP triggers are supported
  http_trigger {
    # Define the HTTP method
    method = "GET"
    # Define the HTTP path
    path   = "/my-function-path"
  }
}

# Create a function deployment
resource "oci_functions_deployment" "main" {
  # The name of the function
  function_name = oci_functions_function.main.name
  # The deployment's version
  version       = "1"
}

# Define the function invocation endpoint
output "function_endpoint" {
  value = oci_functions_function.main.http_trigger.0.endpoint
}
  