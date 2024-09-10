
    # Configure the AWS provider
provider "aws" {
  region = "us-east-1"  # Replace with your desired region
}

# Create a SageMaker endpoint configuration
resource "aws_sagemaker_endpoint_config" "main" {
  name = "my-sagemaker-endpoint-config"
  # Specify the model name
  model_name = "my-sagemaker-model"
  # Set the initial instance count
  initial_instance_count = 1
  # Specify the instance type
  instance_type = "ml.t2.medium"
  # Configure the data capture settings
  data_capture_config {
    capture_options = ["All"]
  }
}

# Create a SageMaker endpoint
resource "aws_sagemaker_endpoint" "main" {
  name = "my-sagemaker-endpoint"
  # Reference the endpoint configuration
  endpoint_config_name = aws_sagemaker_endpoint_config.main.name
}

# Create a SageMaker model
resource "aws_sagemaker_model" "main" {
  name = "my-sagemaker-model"
  # Specify the container image URI
  primary_container {
    image = "520813960204.dkr.ecr.us-east-1.amazonaws.com/sagemaker-xgboost-1:latest"
    model_data_url = "s3://my-s3-bucket/my-model-data"
  }
  # Specify the execution role
  execution_role_arn = aws_iam_role.main.arn
}

# Create an IAM role for the SageMaker model
resource "aws_iam_role" "main" {
  name = "sagemaker-model-role"
  assume_role_policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Principal": {
          "Service": "sagemaker.amazonaws.com"
        },
        "Action": "sts:AssumeRole"
      }
    ]
  })
}

# Attach the AmazonS3FullAccess policy to the IAM role
resource "aws_iam_role_policy" "s3_access" {
  name = "s3-access"
  role = aws_iam_role.main.id
  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Action": [
          "s3:*"
        ],
        "Resource": "*"
      }
    ]
  })
}

# Attach the AmazonSageMakerFullAccess policy to the IAM role
resource "aws_iam_role_policy" "sagemaker_access" {
  name = "sagemaker-access"
  role = aws_iam_role.main.id
  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Action": [
          "sagemaker:*"
        ],
        "Resource": "*"
      }
    ]
  })
}

# Create a SageMaker training job
resource "aws_sagemaker_training_job" "main" {
  training_job_name = "my-training-job"
  # Specify the algorithm
  algorithm_specification {
    training_image = "520813960204.dkr.ecr.us-east-1.amazonaws.com/sagemaker-xgboost-1:latest"
    training_input_mode = "File"
  }
  # Specify the hyperparameters
  hyperparameters = {
    "eta": "0.1",
    "max_depth": "3",
    "objective": "reg:linear"
  }
  # Specify the training data location
  input_data_config {
    s3_data_distribution_type = "ShardedByS3Key"
    s3_data_type = "S3Prefix"
    s3_input_mode = "File"
    data_location = "s3://my-s3-bucket/my-training-data"
  }
  # Specify the output data location
  output_data_config {
    s3_output_path = "s3://my-s3-bucket/my-training-job-output"
  }
  # Specify the role for the training job
  role_arn = aws_iam_role.main.arn
  # Set the training instance type
  resource_config {
    instance_count = 1
    instance_type = "ml.m4.xlarge"
  }
  # Specify the stopping criteria for the training job
  stopping_condition {
    max_runtime_in_seconds = 3600
  }
}

# Create an S3 bucket for storing SageMaker data
resource "aws_s3_bucket" "main" {
  bucket = "my-s3-bucket"
  acl    = "private"
}

  