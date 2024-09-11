
    # Configure the Huawei Cloud provider
provider "huaweicloud" {
  region = "cn-north-1" # Replace with your desired region
}

# Create a CES cluster
resource "huaweicloud_ces_cluster" "main" {
  name = "my-ces-cluster"
  # Specify the cluster configuration
  config {
    # Set the number of nodes in the cluster
    node_num = 3
    # Set the type of nodes in the cluster
    node_type = "ecs.gn5-c8.xlarge"
    # Set the version of the cluster
    version = "2.3.0"
  }
}

# Create a CES instance
resource "huaweicloud_ces_instance" "main" {
  cluster_id = huaweicloud_ces_cluster.main.id
  # Specify the instance configuration
  config {
    # Set the instance type
    instance_type = "ecs.gn5-c8.xlarge"
  }
}

  