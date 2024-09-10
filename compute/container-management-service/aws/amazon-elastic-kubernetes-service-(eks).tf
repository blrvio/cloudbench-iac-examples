
    # Configure the AWS Provider
provider "aws" {
  region = "us-east-1" # Replace with your desired region
}

# Create an EKS Cluster
resource "aws_eks_cluster" "main" {
  name     = "my-eks-cluster"
  role_arn = aws_iam_role.eks_cluster_role.arn
  # Optional: Configure the VPC settings for the cluster
  # vpc_config {
  #   subnet_ids = [aws_subnet.subnet_a.id, aws_subnet.subnet_b.id]
  #   security_group_ids = [aws_security_group.eks_sg.id]
  # }
}

# Create an IAM Role for the EKS Cluster
resource "aws_iam_role" "eks_cluster_role" {
  name = "eks-cluster-role"
  assume_role_policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Principal": {
          "Service": "eks.amazonaws.com"
        },
        "Action": "sts:AssumeRole"
      }
    ]
  })
}

# Attach Policies to the EKS Cluster Role
resource "aws_iam_role_policy_attachment" "eks_cluster_policy" {
  role       = aws_iam_role.eks_cluster_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}

# Create an EKS Node Group
resource "aws_eks_node_group" "main" {
  cluster_name = aws_eks_cluster.main.name
  nodegroup_name = "my-node-group"
  # Define the subnet and security group IDs
  subnet_ids = [aws_subnet.subnet_a.id, aws_subnet.subnet_b.id]
  # Optional: Configure the node group settings
  # scaling_config {
  #   desired_size = 2
  #   min_size = 1
  #   max_size = 3
  # }
  # launch_template {
  #   id = aws_launch_template.node_group_launch_template.id
  # }
}

# Example: Create a Launch Template for the Node Group
resource "aws_launch_template" "node_group_launch_template" {
  name_prefix  = "my-eks-node-group-template"
  image_id      = "ami-08c40ec972c57421d" # Replace with your desired AMI
  instance_type = "t2.medium"
  key_name     = "my-ssh-key"
  # Define the security groups and subnets for the launch template
  # network_interfaces {
  #   subnet_id = aws_subnet.subnet_a.id
  #   security_groups = [aws_security_group.eks_sg.id]
  # }
  # Define the tags for the launch template
  # tag_specifications {
  #   resource_type = "instance"
  #   tags = {
  #     Name = "my-eks-node-group-template"
  #   }
  # }
}

# Example: Create a Security Group for the EKS Cluster
resource "aws_security_group" "eks_sg" {
  name   = "eks-sg"
  # Define ingress and egress rules for the security group
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

# Example: Create Subnets for the EKS Cluster
resource "aws_subnet" "subnet_a" {
  vpc_id            = "vpc-123456789012"
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1a"
}
resource "aws_subnet" "subnet_b" {
  vpc_id            = "vpc-123456789012"
  cidr_block        = "10.0.2.0/24"
  availability_zone = "us-east-1b"
}

  