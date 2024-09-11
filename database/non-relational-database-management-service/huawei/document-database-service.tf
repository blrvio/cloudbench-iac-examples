
    # Configure the Huawei Cloud provider
provider "huaweicloud" {
  region = "eu-west-1"
}

# Create a Document Database Service instance
resource "huaweicloud_dds_instance" "main" {
  name   = "my-dds-instance"
  engine = "MongoDB"
  version = "4.2"
  size   = "small"
  security_group_ids = ["sg-12345678"] # Replace with your security group ID
}

# Create a Document Database Service user
resource "huaweicloud_dds_user" "main" {
  instance_id = huaweicloud_dds_instance.main.id
  username   = "my-dds-user"
  password   = "my-password"
}

# Create a Document Database Service database
resource "huaweicloud_dds_database" "main" {
  instance_id = huaweicloud_dds_instance.main.id
  name        = "my-dds-database"
}

  