
    # Configure the Alibaba Cloud provider
provider "alicloud" {
  region = "cn-hangzhou" # Replace with your desired region
}

# Create a Container Registry namespace
resource "alicloud_acr_namespace" "main" {
  name = "my-acr-namespace" # Replace with your desired namespace name
  # Optional settings
  # description = "My container registry namespace"
  # instance_type = "standard"
  # public_network = true
}

# Create a Container Registry repository
resource "alicloud_acr_repository" "main" {
  name           = "my-acr-repo" # Replace with your desired repository name
  namespace_name = alicloud_acr_namespace.main.name
  # Optional settings
  # description = "My container registry repository"
  # image_tag_immutable = false
}

# Create a Container Registry instance
resource "alicloud_acr_instance" "main" {
  name = "my-acr-instance" # Replace with your desired instance name
  # Optional settings
  # description = "My container registry instance"
  # region_id = "cn-hangzhou"
  # vpc_id = "vpc-abc1234567890"
  # vswitch_id = "vsw-abc1234567890"
  # instance_type = "standard"
  # internet_access = true
}

# Create a Container Registry instance with a custom instance type
# resource "alicloud_acr_instance" "custom_instance" {
#   name = "my-custom-acr-instance"
#   instance_type = "premium"
# }
  