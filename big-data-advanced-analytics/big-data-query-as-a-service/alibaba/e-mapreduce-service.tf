
    # Configure the Alibaba Cloud Provider
provider "alicloud" {
  # Replace with your Alibaba Cloud credentials
  access_key = "YOUR_ACCESS_KEY"
  secret_key = "YOUR_SECRET_KEY"
  region      = "cn-hangzhou"
}

# Create an E-MapReduce cluster
resource "alicloud_emr_cluster" "main" {
  name        = "my-emr-cluster"
  version      = "2.7.2"
  instance_type = "emr.sn1.xlarge"
  instance_count = 2
  # Specify the EMR cluster role
  role_name = "acs:ram::123456789012:role/emr_role"
  # Configure the EMR cluster settings
  settings = <<EOF
core-site:
  fs.defaultFS: hdfs://my-emr-cluster-head-node:8020
EOF
}

# Create an EMR job
resource "alicloud_emr_job" "main" {
  cluster_id = alicloud_emr_cluster.main.id
  name        = "my-emr-job"
  # Specify the EMR job type
  job_type = "spark"
  # Configure the EMR job parameters
  params = {
    spark.app.name = "my-emr-job"
  }
}

  