
    # Configure the IBM Cloud provider
provider "ibm" {
  ibmcloud_api_key = "YOUR_IBM_CLOUD_API_KEY" # Replace with your IBM Cloud API key
  region = "us-south"
}

# Create an IBM Cloud Function
resource "ibm_functions_action" "main" {
  name     = "my-function"
  runtime  = "nodejs:16"
  code     = "// Your function code"
  memory   = 128 # Function memory in MB (default is 128)
  timeout  = 60 # Function timeout in seconds (default is 60)
  package  = "// Path to the function code package"
  namespace = "YOUR_NAMESPACE" # Replace with your IBM Cloud Function namespace

  # Define the function trigger
  trigger {
    type    = "http"
    method  = "GET"
  }
}

# Create a resource to invoke the IBM Cloud Function
resource "ibm_functions_invoke" "main" {
  name     = "my-function-invoke"
  action_name = ibm_functions_action.main.name
  namespace = ibm_functions_action.main.namespace
  method = "GET" # Specify the method for the invocation
}

  