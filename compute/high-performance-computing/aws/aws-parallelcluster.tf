
    # Configure the AWS Provider
provider "aws" {
  region = "us-east-1" # Replace with your desired region
}

# Create a ParallelCluster cluster
resource "aws_parallelcluster_cluster" "main" {
  name = "my-parallelcluster"
  # Set the desired instance types for the cluster
  instance_types = ["c5.xlarge", "m5.large"]
  # Configure the cluster's scheduling policy
  scheduling_policy {
    type = "slurm"
  }
  # Specify the Amazon Machine Image (AMI) for the cluster nodes
  ami_id = "ami-08c40ec972c57421d" # Ubuntu Server 20.04 LTS
  # Configure the cluster's network settings
  network_configuration {
    # Specify the subnet for the cluster nodes
    subnet_id = "subnet-0123456789abcdef0" # Replace with your subnet ID
    # Specify the security group for the cluster nodes
    security_group_ids = ["sg-0123456789abcdef0"] # Replace with your security group IDs
  }
  # Define the desired storage configuration for the cluster
  storage_configuration {
    # Configure the cluster's home directory
    home_directory {
      # Use the default home directory location
      type = "efs"
    }
    # Configure the cluster's scratch directory
    scratch_directory {
      # Use the default scratch directory location
      type = "efs"
    }
  }
  # Configure the cluster's logging settings
  logging_configuration {
    # Configure the cluster's log file location
    log_file_location = "s3://my-bucket/logs"
  }
  # Configure the cluster's monitoring settings
  monitoring_configuration {
    # Enable CloudWatch monitoring
    cloudwatch_monitoring {
      # Enable detailed monitoring metrics
      detailed_monitoring = true
    }
  }
}

# Create a ParallelCluster cluster user
resource "aws_parallelcluster_cluster_user" "main" {
  cluster_id = aws_parallelcluster_cluster.main.id
  # The username to be created
  username = "myuser"
  # Define the user's SSH public key
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCwC5sXh1c+wY5n5Q1F66vR/C2nZ2+W..."
}

  