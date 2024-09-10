
    # Configure the IBM Cloud Provider
provider "ibm" {
  ibmcloud_api_key = "YOUR_IBM_CLOUD_API_KEY" # Replace with your IBM Cloud API key
}

# Create an IBM Cloud Function
resource "ibm_action" "main" {
  name     = "my-cloud-function"
  namespace = "my-namespace"
  kind      = "nodejs:14"
  code      = <<EOF
const express = require('express');
const app = express();
app.get('/', (req, res) => {
  res.send('Hello from IBM Cloud Functions!');
});
exports.main = app;
EOF

  # Optional settings
  memory       = 128
  timeout      = 60
  runtime      = "nodejs:14"
  trigger_type = "http"
  api_key     = "YOUR_API_KEY" # Replace with your API key
}

  