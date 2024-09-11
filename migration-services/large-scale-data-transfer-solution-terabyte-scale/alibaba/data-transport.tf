
    # Configure the Alibaba Cloud Provider
provider "alicloud" {
  # Replace with your Alibaba Cloud credentials
  access_key = "YOUR_ACCESS_KEY"
  secret_key = "YOUR_SECRET_KEY"
  region = "cn-hangzhou"
}

# Create a Data Transport instance
resource "alicloud_dts_instance" "default" {
  # Replace with your desired instance name
  instance_name = "my-data-transport-instance"
  # Replace with your desired instance type
  instance_type = "dt-200"
  # Replace with your desired instance charge type
  pay_type = "postpaid"
  # Replace with your desired instance zone
  zone_id = "cn-hangzhou-a"
  # Replace with your desired instance network type
  network_type = "vpc"
  # Replace with your desired instance vpc id
  vpc_id = "your-vpc-id"
  # Replace with your desired instance vswitch id
  vswitch_id = "your-vswitch-id"
  # Replace with your desired instance security group id
  security_group_id = "your-security-group-id"
}

# Create a Data Transport task
resource "alicloud_dts_task" "default" {
  # Replace with your desired task name
  task_name = "my-data-transport-task"
  # Replace with your desired task type
  task_type = "full"
  # Replace with your desired source instance type
  source_instance_type = "mysql"
  # Replace with your desired source instance connection string
  source_instance_connection_string = "your-source-instance-connection-string"
  # Replace with your desired target instance type
  target_instance_type = "mysql"
  # Replace with your desired target instance connection string
  target_instance_connection_string = "your-target-instance-connection-string"
  # Replace with your desired task instance id
  dts_instance_id = alicloud_dts_instance.default.instance_id
  # Replace with your desired task region
  region = "cn-hangzhou"
}

  