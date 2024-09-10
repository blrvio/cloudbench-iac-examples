
    # Configure the IBM Cloud provider
provider "ibm" {
  # Replace with your IBM Cloud API key
  api_key = "YOUR_IBM_CLOUD_API_KEY"
  # Replace with your IBM Cloud region
  region  = "us-south"
}

# Create a DevOps Insights service instance
resource "ibm_devops_insights_service" "main" {
  name     = "my-devops-insights-service"
  location = ibm_devops_insights_service.main.location
  plan     = "lite"
}

# Create a DevOps Insights toolchain
resource "ibm_devops_insights_toolchain" "main" {
  name     = "my-devops-insights-toolchain"
  location = ibm_devops_insights_toolchain.main.location
  # Replace with your Git repository URL
  git_url = "https://github.com/your-username/your-repo.git"
  # Add your toolchain configuration
  config = {
    "build": {
      "steps": [
        {
          "name": "Build",
          "task": "build"
        },
        {
          "name": "Test",
          "task": "test"
        }
      ]
    },
    "deploy": {
      "steps": [
        {
          "name": "Deploy",
          "task": "deploy"
        }
      ]
    }
  }
}

# Create a DevOps Insights pipeline
resource "ibm_devops_insights_pipeline" "main" {
  name     = "my-devops-insights-pipeline"
  location = ibm_devops_insights_pipeline.main.location
  # Replace with your toolchain ID
  toolchain_id = ibm_devops_insights_toolchain.main.id
  # Replace with your pipeline configuration
  config = {
    "name": "My Pipeline",
    "stages": [
      {
        "name": "Build",
        "steps": [
          {
            "name": "Build",
            "task": "build"
          }
        ]
      },
      {
        "name": "Test",
        "steps": [
          {
            "name": "Test",
            "task": "test"
          }
        ]
      },
      {
        "name": "Deploy",
        "steps": [
          {
            "name": "Deploy",
            "task": "deploy"
          }
        ]
      }
    ]
  }
}

  