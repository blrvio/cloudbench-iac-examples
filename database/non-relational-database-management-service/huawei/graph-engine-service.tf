
    # Configure the Huawei Cloud provider
provider "huaweicloud" {
  region = "cn-north-1" # Replace with your desired region
}

# Create a Graph Engine Service instance
resource "huaweicloud_ges_instance" "main" {
  name         = "my-ges-instance"
  engine_type  = "neo4j" # Supported engine types: neo4j, titan, orientdb
  version       = "4.1" # Supported engine versions: 3.5, 4.1
  spec          = "basic" # Supported specs: basic, standard, advanced
  storage_type  = "SSD" # Supported storage types: SSD, HDD
  storage_size  = 100 # Storage size in GB
  subnet_id     = "subnet-id" # ID of the subnet where the instance will be created
  security_group_id = "security-group-id" # ID of the security group

  # Optional configurations
  # backup_config {
  #   enable    = true
  #   frequency = "daily"
  #   time      = "02:00"
  #   retention = 7
  # }
  # monitoring_config {
  #   enable = true
  # }
  # maintenance_window {
  #   start_time = "02:00"
  #   duration    = "1h"
  # }
  # password = "your-password"
  # tags = {
  #   Name = "my-ges-instance"
  # }
}

  