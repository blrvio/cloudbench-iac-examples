
    # Configure the Huawei Cloud Provider
provider "huaweicloud" {
  region = "cn-north-1"  # Replace with your desired region
}

# Create a ModelArts Workspace
resource "huaweicloud_modelarts_workspace" "main" {
  name     = "my-modelarts-workspace"
  location = "cn-north-1"
  # Optional settings
  # description = "My ModelArts workspace"
  # max_storage = 100
  # max_gpu_cores = 16
  # max_cpu_cores = 64
}

# Create a ModelArts Dataset
resource "huaweicloud_modelarts_dataset" "main" {
  workspace_id = huaweicloud_modelarts_workspace.main.id
  name        = "my-modelarts-dataset"
  # Specify the dataset source and format
  # data_source_type = "oss"
  # data_source_uri = "s3://my-bucket/my-dataset"
  # data_format = "csv"
  # data_split_ratio = [0.8, 0.1, 0.1] # For training, validation, and test sets
  # Optional settings
  # description = "My ModelArts dataset"
  # tags = {
  #   "key1" = "value1"
  #   "key2" = "value2"
  # }
}

# Create a ModelArts Job
resource "huaweicloud_modelarts_job" "main" {
  workspace_id = huaweicloud_modelarts_workspace.main.id
  name        = "my-modelarts-job"
  # Define the training task
  # task_type = "training"
  # model_type = "resnet"
  # training_framework = "tensorflow"
  # dataset_id = huaweicloud_modelarts_dataset.main.id
  # # Optional settings
  # # code_uri = "s3://my-bucket/my-training-code"
  # # model_uri = "s3://my-bucket/my-model"
  # # job_config = {
  # #   "max_runtime" = 3600
  # #   "max_gpu_cores" = 8
  # # }
}

  