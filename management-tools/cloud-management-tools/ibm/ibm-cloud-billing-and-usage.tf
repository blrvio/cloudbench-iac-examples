
    # Configure the IBM Cloud Provider
provider "ibm" {
  api_key = "YOUR_IBM_CLOUD_API_KEY" # Replace with your IBM Cloud API Key
  region  = "us-south" # Replace with your desired region
}

# Retrieve Account Billing Information
resource "ibm_account_billing" "main" {
  account_id = "YOUR_IBM_CLOUD_ACCOUNT_ID" # Replace with your IBM Cloud Account ID
}

# Retrieve Account Usage
resource "ibm_account_usage" "main" {
  account_id = "YOUR_IBM_CLOUD_ACCOUNT_ID" # Replace with your IBM Cloud Account ID
  # Optional Filters for Usage Details
  filter = {
    # Service Name
    service = "YOUR_SERVICE_NAME"
    # Start Date
    start_date = "YYYY-MM-DD"
    # End Date
    end_date = "YYYY-MM-DD"
  }
}
  