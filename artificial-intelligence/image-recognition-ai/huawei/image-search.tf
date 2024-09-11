
    # Configure the Huawei Cloud provider
provider "huaweicloud" {
  region  = "cn-north-1"
  # Replace with your actual region
  # Credentials are required, see https://www.terraform.io/docs/providers/huaweicloud/index.html for more info
}

# Create an Image Search instance
resource "huaweicloud_image_search_instance" "main" {
  name    = "my-image-search-instance"
  # Replace with your actual instance type
  flavor   = "imagesearch.small"
  # Replace with your actual availability zone
  az       = "cn-north-1a"
  # Replace with your actual project ID
  project_id = "your-project-id"
}

# Create an Image Search project
resource "huaweicloud_image_search_project" "main" {
  name = "my-image-search-project"
  # Replace with your actual project ID
  project_id = "your-project-id"
  # Optional: Set the project description
  description = "My Image Search Project"
}

# Create an Image Search dataset
resource "huaweicloud_image_search_dataset" "main" {
  name = "my-image-search-dataset"
  # Replace with your actual project ID
  project_id = "your-project-id"
  # Replace with your actual dataset type
  type = "text"
  # Optional: Set the dataset description
  description = "My Image Search Dataset"
}

  