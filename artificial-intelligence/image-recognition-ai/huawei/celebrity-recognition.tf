
    # Configure the Huawei Cloud provider
provider "huaweicloud" {
  region = "eu-west-1"
}

# Create a Celebrity Recognition project
resource "huaweicloud_roc_project" "main" {
  name = "my-celebrity-recognition-project"
}

# Create a Celebrity Recognition model
resource "huaweicloud_roc_model" "main" {
  project_id = huaweicloud_roc_project.main.id
  name       = "my-celebrity-recognition-model"
  model_type = "FACE_DETECT"
}

# Create a Celebrity Recognition dataset
resource "huaweicloud_roc_dataset" "main" {
  project_id = huaweicloud_roc_project.main.id
  name       = "my-celebrity-recognition-dataset"
  model_id   = huaweicloud_roc_model.main.id
}

# Create a Celebrity Recognition task
resource "huaweicloud_roc_task" "main" {
  project_id = huaweicloud_roc_project.main.id
  name       = "my-celebrity-recognition-task"
  model_id   = huaweicloud_roc_model.main.id
  dataset_id = huaweicloud_roc_dataset.main.id
  # ... add task configuration ...
}

  