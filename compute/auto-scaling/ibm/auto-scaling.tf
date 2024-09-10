
    # Configure the IBM Cloud provider
provider "ibm" {
  region = "us-south"
  api_key = "YOUR_IBM_API_KEY"
}

# Create an Auto Scaling group
resource "ibm_autoscaling_group" "main" {
  name = "my-autoscaling-group"
  # Specify the resource to scale
  resource_type = "ibm_container_service"
  resource_name = "my-container-service"
  # Set the minimum and maximum number of instances
  min_replicas = 1
  max_replicas = 5
  # Define scaling rules
  scaling_rules = [
    {
      metric_name = "cpu_utilization"
      threshold = 80
      # Increase the number of instances by 1 if CPU utilization exceeds 80%
      adjustment_type = "increase"
      adjustment_value = 1
    }
  ]
}

# Create a container service (optional)
resource "ibm_container_service" "my-container-service" {
  name     = "my-container-service"
  location = "us-south"
  # Define the container image to deploy
  containers {
    image = "nginx:latest"
  }
}

  