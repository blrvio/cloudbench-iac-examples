
    # Configure the IBM Cloud provider
provider "ibm" {
  # Configure your IBM Cloud account details
  # Refer to the IBM Terraform provider documentation for details on configuration
  # https://registry.terraform.io/providers/IBM/ibm/latest/docs
}

# Create a Personality Insights service instance
resource "ibm_personality_insights_service" "main" {
  # Specify the name of the service instance
  name = "personality-insights-instance"
  # Specify the IBM Cloud region where the service instance will be created
  region = "us-south"
  # Specify the plan for the service instance
  plan = "lite"
}

# Create a Personality Insights profile
resource "ibm_personality_insights_profile" "main" {
  # Specify the service instance ID
  service_instance_id = ibm_personality_insights_service.main.id
  # Specify the profile name
  name = "my-personality-profile"
  # Specify the profile content
  content = "This is an example text for analysis"
}

# Output the personality insights
output "personality_insights" {
  value = ibm_personality_insights_profile.main.personality
}
  