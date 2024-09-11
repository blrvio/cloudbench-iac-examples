
    # Configure the Oracle Cloud Infrastructure provider
provider "oci" {
  region  = "us-ashburn-1"
  tenancy = "ocid1.tenancy.oc1..aaaaaaaaxxxxxx"
  user    = "ocid1.user.oc1..aaaaaaaayyyyyy"
  key     = "<your_api_key>"
  fingerprint = "<your_fingerprint>"
}

# Create an Oracle Functions application
resource "oci_functions_application" "main" {
  display_name = "my-functions-app"
  # Optional: Set the compartment ID
  compartment_id = "ocid1.compartment.oc1..aaaaaaaazzzzz"
}

# Create an Oracle Functions function
resource "oci_functions_function" "main" {
  display_name = "my-function"
  application_id = oci_functions_application.main.id
  runtime = "nodejs16.x"
  # Optional: Define the function's source code
  source_code = <<EOF
const http = require('http');

const handler = (req, res) => {
  res.writeHead(200, { 'Content-Type': 'text/plain' });
  res.end('Hello from Oracle Functions!');
};

const server = http.createServer(handler);

server.listen(8080, () => {
  console.log('Server running on port 8080');
});
EOF
}

# Create an Oracle Functions trigger
resource "oci_functions_trigger" "main" {
  display_name = "my-trigger"
  function_id = oci_functions_function.main.id
  trigger_type = "http"
  # Optional: Define the trigger's configuration
  http_configuration {
    method = "GET"
  }
}

  