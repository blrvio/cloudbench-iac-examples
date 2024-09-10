
    # Configure the IBM Cloud provider
provider "ibm" {
  region = "us-south"
}

# Create a dedicated host
resource "ibm_vpc_dedicated_host" "main" {
  name = "my-dedicated-host"
  zone = "us-south-1"
  host_type = "bare-metal"
  # Optional: specify the instance type
  instance_type = "bx2.16x32"
  # Optional: specify the subnet where the dedicated host will be deployed
  subnet = "subnet-id"
  # Optional: specify the availability zone
  availability_zone = "us-south-1a"
}

  