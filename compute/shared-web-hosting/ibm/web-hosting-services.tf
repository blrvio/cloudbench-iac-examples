
    # Configure the IBM Cloud provider
provider "ibm-cloud" {
  api_key = "YOUR_IBM_CLOUD_API_KEY"
  region  = "us-south"
}

# Create an IBM Cloud Web Hosting instance
resource "ibm_cloud_hosting_instance" "main" {
  name     = "my-hosting-instance"
  plan_id  = "YOUR_PLAN_ID"
  location = "us-south"
}

# Create an IBM Cloud Web Hosting site
resource "ibm_cloud_hosting_site" "main" {
  hosting_instance_id = ibm_cloud_hosting_instance.main.id
  name                = "my-hosting-site"
  domain              = "my-domain.com"
  # Optionally, configure the site to use HTTPS
  https                = true
}

# Create an IBM Cloud Web Hosting domain
resource "ibm_cloud_hosting_domain" "main" {
  hosting_site_id = ibm_cloud_hosting_site.main.id
  name             = "my-domain.com"
  type             = "A"
  # Optionally, configure the domain to use HTTPS
  https             = true
}

  