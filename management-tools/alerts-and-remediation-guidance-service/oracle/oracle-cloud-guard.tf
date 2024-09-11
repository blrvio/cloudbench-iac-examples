
    # Configure the Oracle Cloud provider
provider "oci" {
  region = "us-ashburn-1"
  # Provide your tenancy OCID and other credentials here
}

# Create a Cloud Guard Detector
resource "oci_cloud_guard_detector" "main" {
  compartment_id = "ocid1.compartment.oc1..aaaaaaaaxxxxxxxxxxxxxx"
  display_name  = "my-cloud-guard-detector"
  # Define the detector type. It could be 'BASIC', 'ADVANCED' or 'CUSTOM'
  detector_type = "BASIC"
  # Add custom rules if needed
  # custom_rules = {
  #  ...
  # }
  # Define the target resources for the detector
  target_resources { 
    target_resource_type = "oci.core.Instance"
    target_resource_ids = ["ocid1.instance.oc1..aaaaaaaaxxxxxxxxxxxxxx"]
  }
}

# Create a Cloud Guard Target
resource "oci_cloud_guard_target" "main" {
  compartment_id = "ocid1.compartment.oc1..aaaaaaaaxxxxxxxxxxxxxx"
  display_name  = "my-cloud-guard-target"
  # Define the target resource type and ID
  target_resource_type = "oci.core.Instance"
  target_resource_id = "ocid1.instance.oc1..aaaaaaaaxxxxxxxxxxxxxx"
}

# Create a Cloud Guard Remediation
resource "oci_cloud_guard_remediation" "main" {
  compartment_id = "ocid1.compartment.oc1..aaaaaaaaxxxxxxxxxxxxxx"
  display_name  = "my-cloud-guard-remediation"
  # Define the remediation action and target
  remediation_action = "oci.cloudguard.remediation.action.StopInstance"
  target_resource_type = "oci.core.Instance"
  target_resource_id = "ocid1.instance.oc1..aaaaaaaaxxxxxxxxxxxxxx"
  # Define the remediation criteria
  # remediation_criteria { 
  #   ...
  # }
}

# Create a Cloud Guard Recipe
resource "oci_cloud_guard_recipe" "main" {
  compartment_id = "ocid1.compartment.oc1..aaaaaaaaxxxxxxxxxxxxxx"
  display_name  = "my-cloud-guard-recipe"
  # Define the recipe type. It could be 'PREDEFINED', 'CUSTOM', or 'POLICY_BASED'
  recipe_type = "PREDEFINED"
  # Define the detector that will use this recipe
  detector_id = oci_cloud_guard_detector.main.id
  # Specify the recipe details based on the recipe type
  # For predefined recipes, provide the recipe name
  recipe_details {
    recipe_name = "PreventPublicIPForEC2"
  }
  # ...
}

  