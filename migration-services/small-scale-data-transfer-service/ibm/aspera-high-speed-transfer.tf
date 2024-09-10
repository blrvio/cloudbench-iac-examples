
    # Configure the IBM Cloud provider
provider "ibm" {
  region = "us-south"
  # Add your IBM Cloud API key
  api_key = "YOUR_IBM_CLOUD_API_KEY"
}

# Create an Aspera Connect server
resource "ibm_aspera_connect_server" "main" {
  name        = "my-aspera-server"
  description = "Example Aspera Connect server"
  location     = "us-south"
  # Add your existing IBM Cloud Object Storage instance ID
  cos_instance_id = "YOUR_COS_INSTANCE_ID"
  # Add your existing IBM Cloud Object Storage bucket name
  bucket_name     = "YOUR_COS_BUCKET_NAME"
}

# Create an Aspera Connect user
resource "ibm_aspera_connect_user" "main" {
  connect_server_id = ibm_aspera_connect_server.main.id
  username        = "my-user"
  password        = "my-password"
  # Optional: Set the user's role
  role           = "admin"
}

  