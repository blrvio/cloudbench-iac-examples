
      # Configure the Alibaba Cloud provider
provider "alicloud" {
  region = "cn-hangzhou"
}

# Create a project
resource "alicloud_odps_project" "example" {
  name     = "example-project"
  location = "cn-hangzhou"
}

# Create a table
resource "alicloud_odps_table" "example" {
  name     = "example_table"
  project  = alicloud_odps_project.example.name
  schema  = <<EOF
  id bigint,
  name string,
  age int
EOF
}

# Create a job
resource "alicloud_odps_job" "example" {
  name     = "example_job"
  project  = alicloud_odps_project.example.name
  type     = "SQL"
  sql      = <<EOF
  INSERT OVERWRITE TABLE example_table
  SELECT 1, 'John Doe', 30;
EOF
}

# Run the job
resource "alicloud_odps_job_run" "example" {
  job_id = alicloud_odps_job.example.id
}
    