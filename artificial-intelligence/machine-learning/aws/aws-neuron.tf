
      # Configure o provedor AWS
provider "aws" {
  region = "us-east-1" # Substitua pela sua região desejada
}

# Crie um recurso Neuron
resource "aws_sagemaker_neuron_runtime" "my_neuron_runtime" {
  name = "my-neuron-runtime"
  runtime_version = "1.0"
}

# Crie um recurso de treinamento do SageMaker usando Neuron
resource "aws_sagemaker_training_job" "my_training_job" {
  training_job_name = "my-training-job"
  algorithm_specification {
    training_image = "your-image-name"
  }
  hyperparameters = {
    "epochs" = 10
  }
  role_arn = "arn:aws:iam::your-account-id:role/your-role-name"
  instance_count = 1
  instance_type = "ml.p3.2xlarge"
  input_data_config {
    s3_data_distribution_type = "FullyReplicated"
    s3_data_type = "S3Prefix"
    s3_uri = "s3://your-bucket/your-data-folder"
  }
  stopping_condition {
    max_runtime_in_seconds = 3600
  }
  neuron {
    runtime = aws_sagemaker_neuron_runtime.my_neuron_runtime.name
  }
}

    