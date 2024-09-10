
    # Configure the IBM Cloud Provider
provider "ibm" {
  api_key    = "YOUR_IBM_API_KEY"
  region     = "us-south"
}

# Create an API Connect instance
resource "ibm_apiconnect_instance" "main" {
  name    = "my-api-connect-instance"
  plan     = "lite"
  region  = "us-south"
  location = "dal10"
  tags = {
    environment = "dev"
  }
}

# Create an API Connect API
resource "ibm_apiconnect_api" "main" {
  instance_id = ibm_apiconnect_instance.main.id
  name        = "my-api"
  base_path   = "/my-api"
  organization = "my-organization"

  # Define the API's definition (replace with your actual definition)
  definition = <<EOF
    {
      "swagger": "2.0",
      "info": {
        "title": "My API",
        "version": "1.0.0"
      },
      "paths": {
        "/hello": {
          "get": {
            "responses": {
              "200": {
                "description": "Success"
              }
            }
          }
        }
      }
    }
EOF

  # Define the API's security settings (replace with your actual configuration)
  security_definition = <<EOF
    {
      "oauth2": {
        "flow": "implicit",
        "authorizationUrl": "https://example.com/oauth/authorize",
        "scopes": {
          "read": "Read access",
          "write": "Write access"
        }
      }
    }
EOF
}

# Create an API Connect Product
resource "ibm_apiconnect_product" "main" {
  instance_id = ibm_apiconnect_instance.main.id
  name        = "my-product"
  organization = "my-organization"

  # Define the Product's API list (replace with your actual list)
  api_list = [ibm_apiconnect_api.main.id]
  # Define the Product's security settings (replace with your actual configuration)
  security_definition = <<EOF
    {
      "oauth2": {
        "flow": "implicit",
        "authorizationUrl": "https://example.com/oauth/authorize",
        "scopes": {
          "read": "Read access",
          "write": "Write access"
        }
      }
    }
EOF
}
  