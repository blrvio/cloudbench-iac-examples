
    # Configure the Alibaba Cloud Provider
provider "alicloud" {
  # Replace with your Alibaba Cloud Access Key ID
  access_key = "your_access_key_id"
  # Replace with your Alibaba Cloud Access Key Secret
  secret_key  = "your_access_key_secret"
  # Replace with your Alibaba Cloud region
  region      = "cn-hangzhou"
}

# Create a Hybrid Backup Recovery Instance
resource "alicloud_hbr_instance" "example" {
  # Replace with the name of your HBR instance
  name = "hbr-instance"
  # Replace with the ID of the VSwitch
  vswitch_id = "your_vswitch_id"
}

# Create a Backup Plan
resource "alicloud_hbr_backup_plan" "example" {
  # Replace with the ID of the HBR instance
  instance_id = alicloud_hbr_instance.example.id
  # Replace with the name of the backup plan
  name = "backup-plan"
  # Replace with the type of backup source (e.g., ECS, RDS, OSS)
  source_type = "ecs"
  # Replace with the ID of the backup source
  source_id = "your_source_id"
  # Replace with the backup schedule (e.g., daily, weekly)
  schedule = "daily"
}

# Create a Backup Policy
resource "alicloud_hbr_backup_policy" "example" {
  # Replace with the ID of the backup plan
  backup_plan_id = alicloud_hbr_backup_plan.example.id
  # Replace with the retention policy (e.g., 30 days)
  retention_period = 30
  # Replace with the backup mode (e.g., incremental, full)
  backup_mode = "incremental"
}

  