
    # Configure the Huawei Cloud provider
provider "huaweicloud" {
  region = "eu-west1"
}

# Create an Image Recognition service
resource "huaweicloud_image_recognition_service" "main" {
  name = "my-image-recognition-service"
}

# Create a model for the service
resource "huaweicloud_image_recognition_model" "main" {
  service_id = huaweicloud_image_recognition_service.main.id
  name = "my-image-recognition-model"
  # Define the model training data
  training_data = "s3://my-bucket/my-training-data.json"
}

# Create a job for the service
resource "huaweicloud_image_recognition_job" "main" {
  service_id = huaweicloud_image_recognition_service.main.id
  model_id = huaweicloud_image_recognition_model.main.id
  name = "my-image-recognition-job"
  # Define the job input data
  input_data = "s3://my-bucket/my-input-data.json"
}

  