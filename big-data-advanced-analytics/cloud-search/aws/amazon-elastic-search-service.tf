
    # Configure the AWS Provider
provider "aws" {
  region = "us-east-1" # Replace with your desired region
}

# Create an Elasticsearch Domain
resource "aws_elasticsearch_domain" "main" {
  domain_name = "my-elasticsearch-domain"
  # Elasticsearch version to use
  elasticsearch_version = "7.10"
  # Configure the Elasticsearch cluster settings
  elasticsearch_cluster_config {
    instance_count = 1 # Number of instances in the cluster
    instance_type = "t2.small.elasticsearch" # Instance type
    zone_awareness_enabled = false # Enable zone awareness
  }
  # Configure the access policies for the Elasticsearch domain
  access_policies = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "AWS": "arn:aws:iam::123456789012:root"
      },
      "Action": "es:*",
      "Resource": "arn:aws:es:us-east-1:123456789012:domain/my-elasticsearch-domain/*"
    }
  ]
}
EOF
  # Configure the EBS volume settings
  ebs_options {
    # Volume type
    volume_type = "gp2"
    # Volume size in GiB
    volume_size = 10
  }

  # Configure the node-to-node encryption settings
  node_to_node_encryption {
    enabled = true
  }
  # Configure the advanced options
  advanced_options = {
    "index.max_result_window": "10000"
  }
  # Configure the tags for the Elasticsearch domain
  tags = {
    Name = "My Elasticsearch Domain"
  }
}

# Create an IAM role for the Elasticsearch domain
resource "aws_iam_role" "main" {
  name = "my-elasticsearch-domain-role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "es.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

# Attach the IAM role to the Elasticsearch domain
resource "aws_elasticsearch_domain_policy" "main" {
  domain_name = aws_elasticsearch_domain.main.domain_name
  access_policies = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "AWS": "arn:aws:iam::123456789012:role/my-elasticsearch-domain-role"
      },
      "Action": "es:*",
      "Resource": "arn:aws:es:us-east-1:123456789012:domain/my-elasticsearch-domain/*"
    }
  ]
}
EOF
}

  