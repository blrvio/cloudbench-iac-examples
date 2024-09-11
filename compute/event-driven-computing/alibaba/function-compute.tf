
    # Configure the Alibaba Cloud Provider
provider "alicloud" {
  region = "cn-hangzhou"
}

# Create a Function Compute service
resource "alicloud_fc_service" "main" {
  name    = "my-fc-service"
  runtime = "nodejs14"
}

# Create a Function Compute function
resource "alicloud_fc_function" "main" {
  service_name = alicloud_fc_service.main.name
  name        = "my-fc-function"
  handler     = "index.handler"
  memory      = 128
  timeout      = 30
  runtime      = "nodejs14"
  code_uri     = "s3://my-bucket/my-function.zip"
}

# Create a Function Compute trigger
resource "alicloud_fc_trigger" "main" {
  service_name = alicloud_fc_service.main.name
  function_name = alicloud_fc_function.main.name
  type         = "http"
  config        = <<EOF
{
  "authType": "anonymous"
}
EOF
}
  