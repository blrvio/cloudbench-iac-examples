
    # Configure the Huawei Cloud provider
provider "huaweicloud" {
  # Replace with your Huawei Cloud region
  region = "cn-north-1"
}

# Create a MapReduce cluster
resource "huaweicloud_mrs_cluster" "main" {
  name = "my-mrs-cluster"
  # Define the cluster specifications
  cluster_spec {
    # Replace with your desired instance type
    instance_type = "mrs.2xlarge"
    # Replace with your desired number of nodes
    instance_count = 3
  }
}

# Create a MapReduce job
resource "huaweicloud_mrs_job" "main" {
  name = "my-mrs-job"
  # Replace with the cluster ID
  cluster_id = huaweicloud_mrs_cluster.main.id
  # Define the job configuration
  job_config {
    # Replace with the MR job path
    mr_job = "path/to/mr_job"
    # Define the input and output locations for the job
    input_path = "path/to/input"
    output_path = "path/to/output"
  }
}

  