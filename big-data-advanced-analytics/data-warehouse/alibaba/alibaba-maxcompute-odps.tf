
    # Configure the Alibaba Cloud Provider
provider "alicloud" {
  region = "cn-hangzhou"
  # Replace with your desired region
}

# Create a MaxCompute Project
resource "alicloud_maxcompute_project" "main" {
  name = "my-maxcompute-project"
  # Replace with your desired project name
}

# Create a MaxCompute Table
resource "alicloud_maxcompute_table" "main" {
  project_name = alicloud_maxcompute_project.main.name
  name         = "my-maxcompute-table"
  # Replace with your desired table name
  # Define table schema
  schema = <<EOF
col1 string
col2 int
EOF
}

# Create a MaxCompute Job
resource "alicloud_maxcompute_job" "main" {
  project_name = alicloud_maxcompute_project.main.name
  name         = "my-maxcompute-job"
  # Replace with your desired job name
  type         = "sql"
  # Define the SQL query to execute
  sql = <<EOF
SELECT * FROM my-maxcompute-table
EOF
}

  