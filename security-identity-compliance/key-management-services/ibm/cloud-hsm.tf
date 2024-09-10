
    # Configure the IBM Cloud provider
provider "ibm-cloud" {
  region = "us-south"
  api_key = "your_ibm_cloud_api_key"
}

# Create a Cloud HSM instance
resource "ibm_cloud_hsm" "main" {
  name = "my-hsm-instance"
  plan = "standard"
  # Optional: Specify the data center to deploy the HSM in
  location = "dal10"
}

# Create a Cloud HSM cluster
resource "ibm_cloud_hsm_cluster" "main" {
  name = "my-hsm-cluster"
  hsm_instance_id = ibm_cloud_hsm.main.id
  # Optional: Specify a custom subnet to deploy the cluster in
  subnet_id = "your_subnet_id"
}

# Create a Cloud HSM client
resource "ibm_cloud_hsm_client" "main" {
  name = "my-hsm-client"
  hsm_cluster_id = ibm_cloud_hsm_cluster.main.id
  # Optional: Specify a custom security group to use for the client
  security_group_id = "your_security_group_id"
}

  