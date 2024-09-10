
    # Configure the IBM Cloud provider
provider "ibm" {
  region = "us-south"
  api_key = "your_ibm_cloud_api_key"
}

# Create an App Configuration service instance
resource "ibm_appconfiguration_service" "main" {
  name     = "my-app-config-service"
  location = "us-south"
  plan     = "lite"
}

# Create an App Configuration configuration
resource "ibm_appconfiguration_configuration" "main" {
  name         = "my-app-config"
  service_name = ibm_appconfiguration_service.main.id
  description = "My application configuration"
}

# Create an App Configuration feature flag
resource "ibm_appconfiguration_feature_flag" "main" {
  name         = "my-feature-flag"
  service_name = ibm_appconfiguration_service.main.id
  description = "My feature flag"
  configuration = ibm_appconfiguration_configuration.main.id
}

# Create an App Configuration secret
resource "ibm_appconfiguration_secret" "main" {
  name         = "my-secret"
  service_name = ibm_appconfiguration_service.main.id
  description = "My secret"
  configuration = ibm_appconfiguration_configuration.main.id
  # Set the secret value
  value = "my-secret-value"
}
  