
    # Configure the IBM Cloud provider
provider "ibm-cloud" {
  api_key = "YOUR_IBM_CLOUD_API_KEY"  # Replace with your actual API key
  region   = "us-south"               # Replace with your desired region
}

# Define the Code Engine service
resource "ibm_codeengine_service" "main" {
  name = "my-code-engine-service"
  location = "us-south"
  # Define the Git repository containing your application
  git_source {
    url = "https://github.com/your-username/your-repo.git"
  }
  # Define the container image to be used
  image {
    name = "your-docker-image-name:latest"
  }
  # Set up the service configuration
  runtime {
    runtime_type = "nodejs18"
    memory = "256"
    cpu = "1"
    # Optionally set up scaling
    scale {
      min_replicas = 1
      max_replicas = 3
    }
  }
  # Optional: Set up routes to access your service
  routes {
    rules {
      name = "my-route"
      path = "/"
      # Map the route to a specific container
      target {
        name = "my-container"
        port = 8080
      }
    }
  }
}

  