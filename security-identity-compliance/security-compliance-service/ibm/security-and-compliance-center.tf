
    # Configure the IBM Cloud Provider
provider "ibm" {
  region = "us-south"
  # Add your IBM Cloud API key
  api_key = "YOUR_IBM_API_KEY"
}

# Create an IBM Cloud Security and Compliance Center account
resource "ibm_scc_account" "main" {
  # Add your desired account ID
  account_id = "YOUR_ACCOUNT_ID"
  name = "My Security Account"
}

# Create a security finding
resource "ibm_scc_finding" "main" {
  account_id = ibm_scc_account.main.account_id
  # Add your finding details
  finding_id    = "finding-1"
  description  = "This is a test finding."
  product_name = "IBM Cloud Security and Compliance Center"
  resource_id   = "your-resource-id"
  severity      = "high"
}

  