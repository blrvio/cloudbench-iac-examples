
    # Configure the Alibaba Cloud provider
provider "alicloud" {
  region = "cn-hangzhou" # Replace with your desired region
}

# Create a Function Compute service
resource "alicloud_fc_service" "main" {
  name = "my-function-compute-service"
  description = "Function Compute service for example"
  # Optional, set a specific role for the service
  # role = "acs:ram::1234567890:role/FC_ROLE_NAME"
}

# Create a Function Compute function
resource "alicloud_fc_function" "main" {
  service_name = alicloud_fc_service.main.name
  function_name = "my-function"
  runtime = "nodejs14"
  handler = "index.handler"
  memory_size = 128
  timeout = 60
  # Optional, define the code location and configuration
  # code_uri = "oss://your-bucket-name/path/to/code.zip"
  # code_sha256 = "SHA256 hash of the code"
  # trigger_config {
  #   trigger_type = "http"
  # }
}

# Create a Function Compute trigger (optional)
# resource "alicloud_fc_trigger" "main" {
#   service_name = alicloud_fc_service.main.name
#   function_name = alicloud_fc_function.main.function_name
#   trigger_name = "my-trigger"
#   trigger_type = "http"
#   trigger_config {
#     # Configure specific trigger properties
#   }
# }
  