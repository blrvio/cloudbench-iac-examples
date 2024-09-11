
    # Configure the Huawei Cloud provider
provider "huaweicloud" {
  region = "eu-west-1"
}

# Create a GaussDB(for Mongo) instance
resource "huaweicloud_gaussdbformongo_instance" "main" {
  name     = "my-gaussdb-instance"
  version  = "5.0"
  # Set the storage capacity
  capacity = 100
  # Set the network configuration
  vpc_id     = "vpc-id"
  subnet_id = "subnet-id"
  # Set the password for the root user
  password  = "my-password"
}

# Create a user for GaussDB(for Mongo)
resource "huaweicloud_gaussdbformongo_user" "main" {
  instance_id = huaweicloud_gaussdbformongo_instance.main.id
  username    = "my-user"
  password    = "my-password"
}

# Create a database for GaussDB(for Mongo)
resource "huaweicloud_gaussdbformongo_database" "main" {
  instance_id = huaweicloud_gaussdbformongo_instance.main.id
  name        = "my-database"
}

  