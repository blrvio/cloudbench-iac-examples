
    # Configure the IBM Cloud provider
provider "ibm" {
  # Replace with your IBM Cloud account credentials
  api_key     = "YOUR_IBM_CLOUD_API_KEY"
  region      = "us-south"
  organization = "YOUR_ORGANIZATION_ID"
}

# Create a Partner Center Organization
resource "ibm_partner_center_organization" "main" {
  name     = "My Partner Organization"
  # Other optional attributes can be added here
}

# Create a Partner Center Account
resource "ibm_partner_center_account" "main" {
  organization_id = ibm_partner_center_organization.main.id
  name            = "My Partner Account"
  # Other optional attributes can be added here
}

# Create a Partner Center Solution
resource "ibm_partner_center_solution" "main" {
  account_id       = ibm_partner_center_account.main.id
  name              = "My Partner Solution"
  description      = "Description of my solution"
  # Other optional attributes can be added here
}

# Create a Partner Center Offering
resource "ibm_partner_center_offering" "main" {
  solution_id = ibm_partner_center_solution.main.id
  name         = "My Partner Offering"
  # Other optional attributes can be added here
}

# Create a Partner Center Marketplace Listing
resource "ibm_partner_center_marketplace_listing" "main" {
  offering_id = ibm_partner_center_offering.main.id
  # Other optional attributes can be added here
}

  