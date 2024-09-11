
    # Configure the Alibaba Cloud Provider
provider "alicloud" {
  region  = "cn-hangzhou" # Replace with your desired region
  # Add your access key and secret key
  # Access keys are not recommended for Terraform, prefer to use RAM roles
  # For more information, see https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/guides/provider_configuration#using-access-keys
  # access_key = "your_access_key"
  # secret_key = "your_secret_key"
}

# Create a Batch Compute Instance
resource "alicloud_batch_compute_instance" "main" {
  # Specify instance type
  instance_type = "ecs.g5.xlarge"  # Replace with your desired instance type
  # Specify instance name
  instance_name = "my-batch-compute-instance"
  # Specify instance role
  instance_role = "acs:ram::123456789012:role/my-batch-compute-instance-role"
  # Specify network type, currently only VPC is supported
  network_type = "vpc"
  # Specify VPC ID
  vpc_id = "vpc-id"
  # Specify subnet ID
  vswitch_id = "vswitch-id"
  # Specify security group ID
  security_group_id = "security-group-id"
  # Specify image ID
  image_id = "image-id"
  # Specify system disk size
  system_disk_size = 100  # Replace with your desired system disk size
  # Specify data disk size
  data_disk_size = 200  # Replace with your desired data disk size
  # Specify data disk type
  data_disk_type = "cloud_efficiency"
  # Specify data disk category
  data_disk_category = "cloud_efficiency"
  # Specify data disk encryption
  data_disk_encrypted = false
  # Specify instance password
  password = "your_password"
  # Specify instance tags
  tags = {
    Name = "my-batch-compute-instance"
  }
}

# Create a Batch Compute Task
resource "alicloud_batch_compute_task" "main" {
  # Specify task name
  task_name = "my-batch-compute-task"
  # Specify task type
  task_type = "normal"
  # Specify task priority
  task_priority = 1
  # Specify task description
  task_description = "my-batch-compute-task-description"
  # Specify instance ID
  instance_id = alicloud_batch_compute_instance.main.id
  # Specify task command
  task_command = "echo \"Hello world!\""
  # Specify task environment variables
  task_env = {
    MY_VAR = "my-value"
  }
  # Specify task working directory
  task_work_dir = "/home/work"
  # Specify task runtime
  task_runtime = 600
  # Specify task restart policy
  task_restart_policy = "no"
}

  