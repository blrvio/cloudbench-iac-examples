
    # Configure the Huawei Cloud provider
provider "huaweicloud" {
  region = "cn-north-1" # Replace with your desired region
}

# Create a Machine Translation Service Instance
resource "huaweicloud_mts_instance" "main" {
  name = "my-mts-instance"
  # Optional settings
  # description = "My Machine Translation Instance"
  # tags = {
  #   Name = "my-mts-instance"
  # }
}

# Create a Machine Translation Service Project
resource "huaweicloud_mts_project" "main" {
  name = "my-mts-project"
  # Optional settings
  # description = "My Machine Translation Project"
  # tags = {
  #   Name = "my-mts-project"
  # }
}

# Create a Machine Translation Service Model
resource "huaweicloud_mts_model" "main" {
  name = "my-mts-model"
  # Optional settings
  # description = "My Machine Translation Model"
  # tags = {
  #   Name = "my-mts-model"
  # }
}

# Create a Machine Translation Service Task
resource "huaweicloud_mts_task" "main" {
  name = "my-mts-task"
  # Optional settings
  # description = "My Machine Translation Task"
  # tags = {
  #   Name = "my-mts-task"
  # }
}

# Create a Machine Translation Service Corpus
resource "huaweicloud_mts_corpus" "main" {
  name = "my-mts-corpus"
  # Optional settings
  # description = "My Machine Translation Corpus"
  # tags = {
  #   Name = "my-mts-corpus"
  # }
}

  