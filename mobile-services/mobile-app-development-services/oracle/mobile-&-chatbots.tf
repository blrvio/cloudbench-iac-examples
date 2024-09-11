
    # Configure the Oracle Cloud provider
provider "oci" {
  region = "us-ashburn-1"
  # Replace with your Oracle Cloud tenancy
  tenancy = "ocid1.tenancy.oc1..."
  # Replace with your user OCID
  user = "ocid1.user.oc1..."
  # Replace with your API Key
  fingerprint = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
  # Replace with your private key file
  private_key_file = "~/.oci/oci_api_key.pem"
}

# Define the Mobile Hub
resource "oci_mobile_hub" "main" {
  display_name = "MyMobileHub"
  # Use resource principal for authentication
  compartment_id = oci_identity_compartment.main.id
  # Optional configurations
  # network_config {
  #   # You can specify the subnet where the Mobile Hub will be deployed
  #   subnet_id = oci_core_subnet.main.id
  # }
}

# Create a compartment for the Mobile Hub
resource "oci_identity_compartment" "main" {
  compartment_id = oci_identity_compartment.main.id
  name          = "MobileHubCompartment"
  description    = "Compartment for Mobile Hub resources"
}

# Create a Mobile Backend Service
resource "oci_mobile_backend_service" "main" {
  display_name = "MyBackendService"
  # Define the Mobile Hub
  mobile_hub_id = oci_mobile_hub.main.id
  # Use resource principal for authentication
  compartment_id = oci_identity_compartment.main.id
  # Optional configurations
  # push_notification_config {
  #   # You can define the push notification provider and configuration
  #   provider = "ONESIGNAL"
  #   # Set the credentials for the provider
  #   credentials {
  #     # Replace with your provider credentials
  #     # onesignal_app_id = "..."
  #     # onesignal_rest_api_key = "..."
  #   }
  # }
}

# Create a Mobile Backend API
resource "oci_mobile_backend_api" "main" {
  display_name = "MyBackendAPI"
  # Define the Mobile Backend Service
  mobile_backend_service_id = oci_mobile_backend_service.main.id
  # Use resource principal for authentication
  compartment_id = oci_identity_compartment.main.id
  # Optional configurations
  # endpoint_config {
  #   # You can specify the endpoint configuration for the API
  #   # endpoint_type = "GATEWAY"
  #   # api_gateway_config {
  #     # You can define the API Gateway configuration for the API
  #     # route_type = "HTTP"
  #     # route_path = "/myapi"
  #   }
  # }
}

# Create a Mobile Backend Authentication
resource "oci_mobile_backend_authentication" "main" {
  display_name = "MyAuthentication"
  # Define the Mobile Backend Service
  mobile_backend_service_id = oci_mobile_backend_service.main.id
  # Use resource principal for authentication
  compartment_id = oci_identity_compartment.main.id
  # Optional configurations
  # authentication_type = "OAUTH2"
  # oauth_config {
  #   # You can define the OAuth2 configuration for the authentication
  #   # provider = "GOOGLE"
  #   # client_id = "..."
  #   # client_secret = "..."
  # }
}

# Create a Mobile Backend Database
resource "oci_mobile_backend_database" "main" {
  display_name = "MyDatabase"
  # Define the Mobile Backend Service
  mobile_backend_service_id = oci_mobile_backend_service.main.id
  # Use resource principal for authentication
  compartment_id = oci_identity_compartment.main.id
  # Optional configurations
  # database_type = "NOSQL"
  # nosql_config {
  #   # You can define the NoSQL configuration for the database
  #   # collection_name = "mycollection"
  # }
}

# Create a Mobile Backend Storage
resource "oci_mobile_backend_storage" "main" {
  display_name = "MyStorage"
  # Define the Mobile Backend Service
  mobile_backend_service_id = oci_mobile_backend_service.main.id
  # Use resource principal for authentication
  compartment_id = oci_identity_compartment.main.id
  # Optional configurations
  # storage_type = "OBJECT_STORAGE"
  # object_storage_config {
  #   # You can define the Object Storage configuration for the storage
  #   # bucket_name = "mybucket"
  # }
}

  