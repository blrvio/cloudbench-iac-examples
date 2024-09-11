
    # Configure the Huawei Cloud Provider
provider "huaweicloud" {
  region = "cn-north-1" # Replace with your desired region
}

# Create a Software Repository
resource "huaweicloud_swr_repository" "main" {
  name     = "my-swr-repository"
  namespace = "my-namespace"
  type     = "private"
}

# Create a SWR Namespace
resource "huaweicloud_swr_namespace" "main" {
  name = "my-namespace"
}

# Create a SWR Package
resource "huaweicloud_swr_package" "main" {
  repository_id = huaweicloud_swr_repository.main.id
  name         = "my-swr-package"
  version      = "1.0.0"
}

  