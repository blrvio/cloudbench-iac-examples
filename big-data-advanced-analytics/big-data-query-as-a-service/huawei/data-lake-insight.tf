
    # Configure the Huawei Cloud provider
provider "huaweicloud" {
  region = "eu-west1" # Replace with your desired region
}

# Create a Data Lake Insight instance
resource "huaweicloud_dli_instance" "main" {
  name     = "my-dli-instance"
  version  = "v1.0"
  data_source  = "s3a://my-data-bucket"
  # Define the Spark configuration
  spark_config = {
    spark.executor.memory = "2g"
    spark.driver.memory = "1g"
  }
  # Set the tags for the instance
  tags = {
    Name = "My Data Lake Insight instance"
  }
}

# Create a Data Lake Insight job
resource "huaweicloud_dli_job" "main" {
  instance_id = huaweicloud_dli_instance.main.id
  name       = "my-dli-job"
  type       = "spark"
  # Define the job configuration
  job_config = <<EOF
{"spark.jars": ["s3a://my-data-bucket/my-spark-jar.jar"],
"spark.submit.deployMode": "cluster",
"spark.executor.memory": "2g",
"spark.driver.memory": "1g",
"spark.app.name": "My Data Lake Insight Job"
}
EOF
}

  