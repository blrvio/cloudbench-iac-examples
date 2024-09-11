
    # Configure the Huawei Cloud provider
provider "huaweicloud" {
  region = "cn-north-1" # Replace with your desired region
}

# Create a FunctionGraph function
resource "huaweicloud_functiongraph_function" "main" {
  name       = "my-function"
  runtime    = "python3.7"
  handler    = "main.handler"
  memory     = 128
  timeout    = 60
  code_uri   = "s3://my-bucket/my-function.zip"
  # You can define environment variables for your function
  environment = {
    key1 = "value1"
    key2 = "value2"
  }
}

# Create a FunctionGraph trigger
resource "huaweicloud_functiongraph_trigger" "main" {
  function_name = huaweicloud_functiongraph_function.main.name
  type          = "http"
  # You can configure additional trigger properties based on your requirements
}

# Create a FunctionGraph deployment configuration
resource "huaweicloud_functiongraph_deployment_config" "main" {
  function_name   = huaweicloud_functiongraph_function.main.name
  # You can define different deployment strategies and configurations
}

  