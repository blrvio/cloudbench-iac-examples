
    # Configure the Alibaba Cloud provider
provider "alicloud" {
  # Set the Alibaba Cloud region
  region = "cn-hangzhou"
}

# Create a MaxCompute project
resource "alicloud_maxcompute_project" "default" {
  name = "my-maxcompute-project"
}

# Create a MaxCompute table
resource "alicloud_maxcompute_table" "default" {
  project_name = alicloud_maxcompute_project.default.name
  name         = "my-maxcompute-table"
  # Define the table schema
  schema = <<EOF
    id BIGINT NOT NULL COMMENT 'ID',
    name VARCHAR(100) NOT NULL COMMENT 'Name',
    age INT COMMENT 'Age'
    
EOF
  # Create a new table
  create_if_not_exists = true
}

# Create a MaxCompute table partition
resource "alicloud_maxcompute_table_partition" "default" {
  project_name = alicloud_maxcompute_project.default.name
  table_name   = alicloud_maxcompute_table.default.name
  # Define the partition key
  partition_spec = "dt=20230401"
}

# Create a MaxCompute job
resource "alicloud_maxcompute_job" "default" {
  # Set the project name
  project_name = alicloud_maxcompute_project.default.name
  # Set the job name
  name = "my-maxcompute-job"
  # Set the job type
  type = "sql"
  # Define the job parameters
  params = {
    "input_table" = alicloud_maxcompute_table.default.name
    "output_table" = "my-maxcompute-output-table"
  }
  # Define the job script
  script = <<EOF
CREATE TABLE my-maxcompute-output-table AS
SELECT id, name, age
FROM my-maxcompute-table;
EOF
}

  