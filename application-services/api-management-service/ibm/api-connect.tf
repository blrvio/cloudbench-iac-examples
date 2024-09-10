
    # Configure the IBM Cloud provider
provider "ibm" {
  api_key  = "YOUR_IBM_CLOUD_API_KEY"
  region    = "us-south"
  org_id   = "YOUR_ORG_ID"
  account_id = "YOUR_ACCOUNT_ID"
}

# Create a new IBM Cloud App Connect flow
resource "ibm_appconnect_flow" "main" {
  name = "my-appconnect-flow"
  # Define the flow definition using the YAML syntax
  definition = <<EOF
---
openapi: 3.0.0
info:
  version: "1.0.0"
  title: "My App Connect Flow"
paths:
  /hello:
    get:
      summary: "Simple hello world"
      responses:
        '200':
          description: "Successful response"
          content:
            application/json:
              schema:
                type: string
                example: "Hello World!"
EOF
}

# Create a connection to a resource using the App Connect connector
resource "ibm_appconnect_connection" "main" {
  name         = "my-appconnect-connection"
  flow_id      = ibm_appconnect_flow.main.id
  type         = "generic"
  connector_id = "your-connector-id"
  # Define the connection configuration
  properties = <<EOF
---
host: "your-host"
port: "your-port"
username: "your-username"
password: "your-password"
EOF
}
  