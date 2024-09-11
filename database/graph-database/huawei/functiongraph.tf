
    # Configure the Huawei Cloud provider
provider "huaweicloud" {
  region = "cn-north-1" # Replace with your desired region
}

# Create a FunctionGraph function
resource "huaweicloud_functiongraph_function" "main" {
  name     = "my-function"
  runtime  = "python3.9"
  handler  = "main.handler"
  code_uri = "s3://my-bucket/my-function.zip" # Replace with your S3 bucket and function code
  memory   = 128
  timeout  = 60
  # Define the triggers for the function
  trigger {
    type = "http"
  }
  # Add tags to the function
  tags = {
    Name = "My FunctionGraph Function"
  }
}

  