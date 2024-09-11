
    # Configure the Alibaba Cloud provider
provider "alicloud" {
  # Replace with your Alibaba Cloud credentials
  access_key = "YOUR_ACCESS_KEY"
  secret_key = "YOUR_SECRET_KEY"
  region     = "cn-hangzhou"
}

# Create a Disaster Recovery (DR) group
resource "alicloud_dr_group" "main" {
  name = "my-dr-group"
  # Configure the source and target regions for the DR group
  source_region = "cn-hangzhou"
  target_region = "cn-beijing"
}

# Create a DR plan
resource "alicloud_dr_plan" "main" {
  dr_group_id = alicloud_dr_group.main.id
  name = "my-dr-plan"
  # Define the type of DR plan
  plan_type = "full"
}

# Create a DR task
resource "alicloud_dr_task" "main" {
  dr_plan_id = alicloud_dr_plan.main.id
  name = "my-dr-task"
  # Define the type of DR task
  task_type = "full"
  # Configure the source and target instances
  source_instance_ids = ["i-xxxxxx", "i-yyyyyy"]
  target_instance_ids = ["i-zzzzzz"]
}

  