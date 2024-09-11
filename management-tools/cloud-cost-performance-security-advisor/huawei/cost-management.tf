
    # Configure the Huawei Cloud provider
provider "huaweicloud" {
  region = "eu-west-1" # Replace with your desired region
}

# Create a cost center
resource "huaweicloud_cost_center" "main" {
  name     = "MyCostCenter"
  # Optional parameters
  description = "My cost center description"
  # You can add additional parameters here based on your needs
}

# Create a cost allocation rule
resource "huaweicloud_cost_allocation_rule" "main" {
  cost_center_id  = huaweicloud_cost_center.main.id
  name            = "MyAllocationRule"
  description     = "My cost allocation rule description"
  # Define the allocation rule parameters
  rule_type = "RESOURCE_TYPE"
  rule_value = "INSTANCE"
  # You can add additional parameters here based on your needs
}

  