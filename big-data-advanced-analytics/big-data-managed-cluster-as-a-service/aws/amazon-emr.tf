
      # Configure o provedor AWS
provider "aws" {
  region = "us-east-1"
}

# Crie um cluster EMR
resource "aws_emr_cluster" "example" {
  name             = "example-emr-cluster"
  release_label    = "emr-5.29.0"
  applications     = ["hadoop", "hive", "spark"]
  service_role     = "arn:aws:iam::xxxxxxxx:role/emr_role"
  instance_groups  = [{"instance_group_type": "MASTER", "instance_type": "m5.xlarge", "instance_count": 1}, {
    "instance_group_type": "CORE", "instance_type": "m5.large", "instance_count": 2
  }]
  bootstrap_actions = [{"name": "install_python_packages", "script_bootstrap_action": {
    "path": "s3://bucket-name/emr-bootstrap-scripts/install_python.sh"
  }}]
  configurations = [{
    "classification": "hadoop-env",
    "properties": {
      "hadoop_env.java_home": "/usr/lib/jvm/java-1.8.0-openjdk-amd64/"
    }
  }]

  # Adicione tags para o cluster
  tags = {
    Name = "example-emr-cluster"
  }
}
    