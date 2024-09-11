
    # Configure the Alibaba Cloud provider
provider "alicloud" {
  region = "cn-hangzhou" # Replace with your desired region
}

# Create a RAM user
resource "alicloud_ram_user" "main" {
  name = "my-ram-user" # Name of the RAM user
  display_name = "My RAM User"
  # Optional: Set the user's email address
  # email = "user@example.com"
}

# Create an access key for the RAM user
resource "alicloud_ram_access_key" "main" {
  user_name = alicloud_ram_user.main.name # Name of the RAM user
  # Optional: Set a description for the access key
  # description = "Access key for My RAM User"
}

# Attach a policy to the RAM user
resource "alicloud_ram_user_policy_attachment" "main" {
  user_name = alicloud_ram_user.main.name # Name of the RAM user
  policy_name = "AdministratorAccess" # Name of the policy to attach
  # Optional: Set a description for the policy attachment
  # description = "Attach AdministratorAccess policy to My RAM User"
}

# Create a RAM group
resource "alicloud_ram_group" "main" {
  name = "my-ram-group" # Name of the RAM group
  # Optional: Set a description for the RAM group
  # description = "My RAM Group"
}

# Add a RAM user to the RAM group
resource "alicloud_ram_group_membership" "main" {
  group_name = alicloud_ram_group.main.name # Name of the RAM group
  user_name = alicloud_ram_user.main.name # Name of the RAM user
  # Optional: Set a description for the group membership
  # description = "Add My RAM User to My RAM Group"
}

  