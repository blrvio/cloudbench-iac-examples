
      ## Configure the Huawei Cloud Provider
provider "huaweicloud" {
  region = "eu-west-1"
}

# Create a ModelArts workspace
resource "huaweicloud_modelarts_workspace" "my_workspace" {
  name  = "my-workspace"
  region = "eu-west-1"
}

# Create a training job
resource "huaweicloud_modelarts_training_job" "my_training_job" {
  workspace_id = huaweicloud_modelarts_workspace.my_workspace.id
  name         = "my-training-job"
  code_url     = "https://github.com/example/my-model.git"
  framework    = "tensorflow"
  entry_point  = "train.py"
  dataset_id  = "ds-xxxxxxxx"
}

# Create a model deployment
resource "huaweicloud_modelarts_model_deployment" "my_model_deployment" {
  workspace_id = huaweicloud_modelarts_workspace.my_workspace.id
  name         = "my-model-deployment"
  model_id     = huaweicloud_modelarts_training_job.my_training_job.model_id
  endpoint_type = "online"
}

# Create a ModelArts endpoint
resource "huaweicloud_modelarts_endpoint" "my_endpoint" {
  workspace_id  = huaweicloud_modelarts_workspace.my_workspace.id
  name           = "my-endpoint"
  deployment_id = huaweicloud_modelarts_model_deployment.my_model_deployment.id
}

    