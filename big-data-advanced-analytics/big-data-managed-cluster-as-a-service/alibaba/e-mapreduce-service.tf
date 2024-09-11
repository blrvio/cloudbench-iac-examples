
    # Configure the Alibaba Cloud Provider
provider "alicloud" {
  region  = "cn-hangzhou"
  # Add your Alibaba Cloud Access Key ID and Secret Access Key here
  access_key = "YOUR_ACCESS_KEY_ID"
  secret_key = "YOUR_SECRET_ACCESS_KEY"
}

# Create a EMR cluster
resource "alicloud_emr_cluster" "default" {
  name      = "my-emr-cluster"
  version   = "3.5.0"
  instance_type   = "e2.large"
  # Define the EMR cluster roles
  role_list = ["EMR_Role","OSS_Role"]
  # Define the EMR cluster configurations
  configs = <<EOF
{ "spark.default.parallelism": "4", "spark.executor.instances": "4" }
EOF
  # Define the EMR cluster security configuration
  security_group_id = "your-security-group-id"
}

# Create a EMR job
resource "alicloud_emr_job" "default" {
  name     = "my-emr-job"
  cluster_id  = alicloud_emr_cluster.default.id
  type     = "spark"
  run_mode   = "cluster"
  # Define the EMR job configurations
  configs = <<EOF
{ "spark.default.parallelism": "4", "spark.executor.instances": "4" }
EOF
  # Define the EMR job code
  code = <<EOF
import org.apache.spark.SparkConf
import org.apache.spark.SparkContext
import org.apache.spark.sql.SparkSession

object SparkJob {
  def main(args: Array[String]): Unit = {
    // Create a Spark session
    val spark = SparkSession.builder
      .appName("My Spark Job")
      .getOrCreate()

    // Load data from S3
    val data = spark.read.csv("s3a://your-bucket/data.csv")

    // Perform data analysis
    // ...

    // Save results to S3
    data.write.mode("overwrite").csv("s3a://your-bucket/results.csv")

    spark.stop()
  }
}
EOF
}

# Create a EMR cluster security configuration
resource "alicloud_emr_security_configuration" "default" {
  name     = "my-emr-security-configuration"
  # Define the security configuration rules
  rules = <<EOF
[{"rule": {"id": "hadoop", "resource": "hadoop", "policy": "ALLOW"}}]
EOF
}

# Attach the security configuration to the EMR cluster
resource "alicloud_emr_security_configuration_association" "default" {
  cluster_id            = alicloud_emr_cluster.default.id
  security_configuration_id = alicloud_emr_security_configuration.default.id
}

  