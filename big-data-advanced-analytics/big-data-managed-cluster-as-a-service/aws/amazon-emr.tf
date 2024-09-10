
    # Configure the AWS Provider
provider "aws" {
  region = "us-east-1" # Replace with your desired region
}

# Create an EMR Cluster
resource "aws_emr_cluster" "main" {
  name          = "my-emr-cluster"
  release_label = "emr-5.29.0" # Specify the EMR release label
  applications  = [
    {
      name = "Hadoop"
    },
    {
      name = "Hive"
    },
    {
      name = "Spark"
    }
  ]
  configurations = [
    {
      classification = "hadoop-env"
      properties = {
        "hadoop.proxyuser.hdfs.hosts" = "*"
        "hadoop.proxyuser.hdfs.groups" = "hadoop"
      }
    },
    {
      classification = "spark-env"
      properties = {
        "spark.yarn.access.control.enabled" = "false"
      }
    }
  ]
  # Define the master node instance type
  master_instance_type = "m5.xlarge"
  # Define the core node instance type
  core_instance_type  = "m5.large"
  # Define the number of core nodes
  core_instance_count = 2
  # Define the instance type for the job flow
  instance_type = "m5.xlarge"
  # Define the EBS configuration for the cluster
  ebs_configuration {
    # Define the volume specification for the EBS
    ebs_optimized = true # Enable EBS optimization for the instances
    volume_type   = "gp2"
    volume_size   = 100 # Size of the EBS volume in GB
  }
  # Configure the cluster logs
  log_uri = "s3://my-emr-logs-bucket/logs"
  # Configure the security configuration for the cluster
  security_configuration {  # Optional
    name = "my-emr-security-configuration"
  }
  # Configure the tags for the cluster
  tags = {
    Name = "My EMR Cluster"
  }
}

# Create an EMR Security Configuration
resource "aws_emr_security_configuration" "main" {
  name = "my-emr-security-configuration"
  # Define the security configuration details
  security_configuration {
    # Configure the security groups for the cluster
    security_group_ids = [aws_security_group.main.id]
  }
}

# Create a security group for the EMR cluster
resource "aws_security_group" "main" {
  name   = "sg-emr"
  # Define the ingress and egress rules
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

  