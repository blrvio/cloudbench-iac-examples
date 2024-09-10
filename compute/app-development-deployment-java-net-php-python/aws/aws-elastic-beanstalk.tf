
    # Configure the AWS provider
provider "aws" {
  region = "us-east-1" # Replace with your desired region
}

# Create an Elastic Beanstalk application
resource "aws_elasticbeanstalk_application" "main" {
  name = "my-elasticbeanstalk-app" # Name of your Elastic Beanstalk application
}

# Create an Elastic Beanstalk environment
resource "aws_elasticbeanstalk_environment" "main" {
  application_name = aws_elasticbeanstalk_application.main.name # Name of the Elastic Beanstalk application
  environment_name = "my-elasticbeanstalk-env" # Name of the Elastic Beanstalk environment
  solution_stack_name = "64bit Amazon Linux 2 v3.1.5 running Node.js 14.x" # Solution stack to use for the environment
  # Define the CNAME prefix for the environment
  cname_prefix = "my-elasticbeanstalk-env"
  # Configure the tier of the environment
  tier {
    name = "WebServer"
    type = "Standard"
    # Define the instance type for the environment
    instance_type = "t2.micro"
    # Configure the version of the application to deploy to the environment
    version_label = aws_elasticbeanstalk_application_version.main.version_label
  }
  # Define the tags for the environment
  tags = {
    Name = "My Elastic Beanstalk Environment"
  }
}

# Create an Elastic Beanstalk application version
resource "aws_elasticbeanstalk_application_version" "main" {
  application_name = aws_elasticbeanstalk_application.main.name # Name of the Elastic Beanstalk application
  source_bundle {
    s3_bucket = "my-s3-bucket" # Name of the S3 bucket containing the application source code
    s3_key    = "my-app-source.zip" # Key of the S3 object containing the application source code
  }
  # Set the version label for the application version
  version_label = "my-app-version"
}

# Optionally, create a load balancer for the environment
#resource "aws_elb" "main" {
#  name = "my-elasticbeanstalk-elb"
#  subnets = [aws_subnet.main.id]
#  # Define the security groups for the load balancer
#  security_groups = [aws_security_group.main.id]
#  # Configure the health check settings
#  health_check {
#    target = "HTTP:80/index.html" # Target for the health check
#    timeout = 5 # Timeout for the health check
#    interval = 20 # Interval for the health check
#    healthy_threshold = 2 # Number of successful health checks required to consider the instance healthy
#    unhealthy_threshold = 2 # Number of failed health checks required to consider the instance unhealthy
#  }
#}

# Optionally, create a security group for the load balancer
#resource "aws_security_group" "main" {
#  name   = "sg-elb"
#  # Define the ingress and egress rules for the security group
#  ingress {
#    from_port   = 80
#    to_port     = 80
#    protocol    = "tcp"
#    cidr_blocks = ["0.0.0.0/0"]
#  }
#  egress {
#    from_port   = 0
#    to_port     = 0
#    protocol    = "tcp"
#    cidr_blocks = ["0.0.0.0/0"]
#  }
#}

# Optionally, create a subnet for the load balancer
#resource "aws_subnet" "main" {
#  vpc_id = "vpc-1234567890abcdef0" # Replace with the ID of your VPC
#  cidr_block = "10.0.0.0/24" # CIDR block for the subnet
#  # Define the Availability Zone for the subnet
#  availability_zone = "us-east-1a"
#}

  