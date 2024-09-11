
    # Configure the Huawei Cloud provider
provider "huaweicloud" {
  region = "cn-north-1" # Replace with your desired region
}

# Create a DRS replication task
resource "huaweicloud_drs_replication_task" "main" {
  name              = "my-drs-replication-task"
  source_instance_id = "i-123456789012"
  # Source instance ID
  target_instance_id = "i-987654321012"
  # Target instance ID
  replication_mode  = "full"
  # Replication mode (full or incremental)
  # Define the replication schedule
  schedule {
    start_time = "00:00"
    # Start time of the replication
    interval     = "30m"
    # Replication interval
  }
}

  