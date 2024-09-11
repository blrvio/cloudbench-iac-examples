
    # Configure the Huawei Cloud provider
provider "huaweicloud" {
  # Replace with your Huawei Cloud region
  region = "eu-west-1"
}

# Create a Data Encryption Workshop (DEW) instance
resource "huaweicloud_dew_instance" "main" {
  # Replace with a valid DEW instance name
  name = "my-dew-instance"
  # Specify the DEW instance type
  type = "Standard"
  # Specify the DEW instance size
  size = "Small"
  # Configure the DEW instance network
  network {
    # Specify the VPC ID
    vpc_id = "vpc-xxxxxxxx"
    # Specify the subnet ID
    subnet_id = "subnet-xxxxxxxx"
    # Configure the security group
    security_group {
      # Specify the security group ID
      security_group_id = "sg-xxxxxxxx"
    }
  }
  # Configure the DEW instance storage
  storage {
    # Specify the storage type
    type = "HDD"
    # Specify the storage size
    size = "100GB"
  }
  # Configure the DEW instance log
  log {
    # Enable log collection
    enable_log_collection = true
    # Specify the log storage location
    log_storage_location = "oss://my-bucket/logs"
  }
}

# Create a DEW user
resource "huaweicloud_dew_user" "main" {
  # Replace with a valid user name
  name = "my-dew-user"
  # Specify the DEW instance ID
  dew_instance_id = huaweicloud_dew_instance.main.id
  # Specify the user role
  role = "admin"
  # Set the user password
  password = "MySecurePassword123"
  # Configure the user security settings
  security {
    # Enable password authentication
    enable_password_authentication = true
  }
}

# Create a DEW policy
resource "huaweicloud_dew_policy" "main" {
  # Replace with a valid policy name
  name = "my-dew-policy"
  # Specify the DEW instance ID
  dew_instance_id = huaweicloud_dew_instance.main.id
  # Configure the policy rules
  rules = [
    # Allow the user to access the DEW instance
    {
      # Specify the action
      action = "dew:Read"
      # Specify the resource
      resource = "dew:instance/my-dew-instance"
    }
  ]
}

  