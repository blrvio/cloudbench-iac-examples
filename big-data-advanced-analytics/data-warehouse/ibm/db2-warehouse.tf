
    # Configure the IBM Cloud provider
provider "ibm-cloud" {
  region = "us-south"
  api_key = "YOUR_IBM_CLOUD_API_KEY"
}

# Create a Db2 Warehouse service
resource "ibm_db2_warehouse" "main" {
  name               = "my-db2-warehouse"
  instance_size       = "1x4"
  storage_gb          = 100
  pricing_plan        = "pay-per-hour"
  region              = "us-south"
  resource_group_id    = "YOUR_RESOURCE_GROUP_ID"
}

# Create a Db2 Warehouse user
resource "ibm_db2_warehouse_user" "main" {
  db2_warehouse_id = ibm_db2_warehouse.main.id
  username          = "my_db2_user"
  password          = "my_db2_password"
  role               = "ADMIN"
}

# Create a Db2 Warehouse database
resource "ibm_db2_warehouse_database" "main" {
  db2_warehouse_id = ibm_db2_warehouse.main.id
  name               = "my_db2_database"
}

  