
    # Configure the Huawei Cloud provider
provider "huaweicloud" {
  region = "eu-west-1" # Replace with your desired region
}

# Create a ServiceStage instance
resource "huaweicloud_servicestage_instance" "main" {
  name = "my-servicestage-instance"
  # Define the instance type
  instance_type = "basic"
  # Configure the access policy
  access_policy {
    open_access = true # Enable public access
  }
  # Define the basic authentication settings
  basic_auth {
    enable = false # Disable basic authentication
  }
  # Define the CORS configuration
  cors {
    allow_origin = ["*"] # Allow all origins
    allow_method = ["GET", "POST", "PUT", "DELETE"] # Allow all methods
    allow_header = ["Content-Type", "Authorization"] # Allow specific headers
  }
}

# Create a ServiceStage service
resource "huaweicloud_servicestage_service" "main" {
  instance_id = huaweicloud_servicestage_instance.main.id
  name = "my-service"
  # Define the service type
  type = "http"
  # Define the service endpoint
  endpoint {
    url = "https://my-service.servicestage.cn-north-1.myhuaweicloud.com"
    # Define the authentication settings
    auth {
      # Define the basic authentication settings
      basic {
        enable = false # Disable basic authentication
      }
    }
  }
}

  