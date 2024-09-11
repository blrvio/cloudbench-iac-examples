
    # Configure the Alibaba Cloud Provider
provider "alicloud" {
  region = "cn-hangzhou"
  # Replace with your desired region
  # Add other provider configuration options if needed
}

# Create a Truster Center Role
resource "alicloud_truster_center_role" "example" {
  name = "my-truster-center-role"
  description = "Truster Center Role for managing trust relationships"
  # Other optional attributes, like `user_role_id` and `role_type`
}

# Create a Truster Center Trust Relationship
resource "alicloud_truster_center_trust_relationship" "example" {
  role_name = alicloud_truster_center_role.example.name
  # Other optional attributes, like `trusted_account_id` and `trust_relation_type`
}

  