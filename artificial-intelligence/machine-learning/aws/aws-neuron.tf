
    # Configure the AWS Provider
provider "aws" {
  region = "us-east-1" # Replace with your desired region
}

# Create an Amazon SageMaker Model
resource "aws_sagemaker_model" "main" {
  name = "my-neuron-model" # Name of your SageMaker Model
  primary_container {
    image = "763104351884.dkr.ecr.us-east-1.amazonaws.com/sagemaker-neuron-inference:latest" # Neuron Inference Container Image
    model_data_url = "s3://your-bucket-name/model/your-model-file.tar.gz" # Path to your model file
  }
  # Optional: Define an execution role for the model
  execution_role_arn = "arn:aws:iam::123456789012:role/your-role-name"
  # Define tags for the model
  tags = {
    Name = "My Neuron Model"
  }
}

# Create an Amazon SageMaker Endpoint Configuration
resource "aws_sagemaker_endpoint_config" "main" {
  name = "my-neuron-endpoint-config" # Name of your Endpoint Configuration
  production_variants {
    initial_instance_count = 1 # Number of instances to launch initially
    instance_type = "ml.p3.2xlarge" # Choose a Neuron-supported instance type
    model_name = aws_sagemaker_model.main.name # Name of the SageMaker Model
    variant_name = "main" # Name of the variant
  }
}

# Create an Amazon SageMaker Endpoint
resource "aws_sagemaker_endpoint" "main" {
  name = "my-neuron-endpoint" # Name of your Endpoint
  endpoint_config_name = aws_sagemaker_endpoint_config.main.name # Name of the Endpoint Configuration
  tags = {
    Name = "My Neuron Endpoint"
  }
}

  