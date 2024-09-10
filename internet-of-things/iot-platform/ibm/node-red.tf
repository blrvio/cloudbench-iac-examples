
    # Configure the IBM Cloud provider
provider "ibm" {
  # Replace with your IBM Cloud API key
  api_key = "YOUR_API_KEY"
  # Replace with your IBM Cloud region
  region = "us-south"
}

# Create a Node-RED application
resource "ibm_appservice_app" "main" {
  name = "my-node-red-app"
  # Replace with the starter kit ID for Node-RED
  starter_kit_id = "59c9d5bd-4d31-3611-897a-f94eea80dc9f"
  # Choose the runtime for Node-RED
  runtime = "node.js"
  # Replace with the desired version
  runtime_version = "16.x"
}

# Create a service binding for Node-RED
resource "ibm_appservice_servicebinding" "main" {
  app_id = ibm_appservice_app.main.id
  # Replace with the service ID for the service you want to bind
  service_id = "YOUR_SERVICE_ID"
  # Replace with the service plan ID
  service_plan_id = "YOUR_SERVICE_PLAN_ID"
}

  