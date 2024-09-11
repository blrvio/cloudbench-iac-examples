
    # Configure the Huawei Cloud provider
provider "huaweicloud" {
  region = "eu-west-1" # Replace with your desired region
}

# Create a Container Instance
resource "huaweicloud_cci_instance" "main" {
  name = "my-container-instance"
  # Optional: Specify a custom container image
  image = "docker.io/library/nginx:latest"
  # Specify the resources for the instance
  resources {
    cpu = 1
    memory = 1024
  }

  # Optional: Define a custom network configuration
  network_config {
    vpc_id = "<vpc_id>"
    subnet_id = "<subnet_id>"
  }

  # Optional: Configure security groups
  security_groups = ["<security_group_id>"]
}

  