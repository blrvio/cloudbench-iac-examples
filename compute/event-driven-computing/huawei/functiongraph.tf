
    # Configure the Huawei Cloud Provider
provider "huaweicloud" {
  region = "eu-west1" # Replace with your desired region
}

# Create a FunctionGraph Function
resource "huaweicloud_functiongraph_function" "main" {
  name = "my-function"
  runtime = "python3.9"
  # You can specify a code path to a file or folder in your local environment
  code_uri = "path/to/code"
  handler = "my_module.my_function"
  # Set the trigger type for the function (e.g., HTTP, Timer, Event)
  trigger_type = "HTTP"
  timeout = 60 # Timeout in seconds for function execution
  memory = 128 # Memory allocation in MB for the function

  # Configure the FunctionGraph environment variables
  environment_variables = {
    "MY_VARIABLE" = "value"
  }

  # Optional: Set the function's access control list (ACL)
  # acl_config {
  #   # Configure the FunctionGraph ACL permissions
  #   allow_public_access = true # Allow public access to the function
  # }

  # Optional: Set the function's VPC configuration
  # vpc_config {
  #   subnet_id = "subnet-id"
  #   security_group_id = "sg-id"
  # }
}

# Create a FunctionGraph Trigger
# resource "huaweicloud_functiongraph_trigger" "main" {
#  function_name = huaweicloud_functiongraph_function.main.name
#  trigger_type = "HTTP"
#  # Optional: Specify a custom trigger path
#  path = "/my-trigger-path"
# }

  