
    # Configure the Huawei Cloud provider
provider "huaweicloud" {
  # Replace with your Huawei Cloud credentials
  access_key_id     = "YOUR_ACCESS_KEY_ID"
  secret_access_key = "YOUR_SECRET_ACCESS_KEY"
  region            = "cn-north-1" # Replace with your region
}

# Create a GES instance
resource "huaweicloud_ges_instance" "main" {
  # Replace with your desired instance configuration
  name  = "my-ges-instance"
  flavor = "GES.SMALL"
  # Optional settings
  # version = "2.0"
  # storage_type = "SSD"
  # storage_size = 100
  # vpc_id = "vpc-xxx"
  # subnet_id = "subnet-xxx"
  # security_group_id = "sg-xxx"
}

# Create a GES schema
resource "huaweicloud_ges_schema" "main" {
  # Replace with your desired schema
  name     = "my-ges-schema"
  instance = huaweicloud_ges_instance.main.id
  # Optional settings
  # description = "My GES schema"
  # schema_content = "\"\"\n  # graph { \n  #   vertex { ... }\n  #   edge { ... }\n  # }\n  # \"\"\"
}

# Create a GES index
resource "huaweicloud_ges_index" "main" {
  # Replace with your desired index
  name         = "my-ges-index"
  schema       = huaweicloud_ges_schema.main.id
  index_type  = "HASH"
  index_fields = ["id"]
}

  