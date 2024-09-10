
    # Configure the IBM Cloud provider
provider "ibm" {
  region  = "us-south"
  account_id = "<YOUR_IBM_CLOUD_ACCOUNT_ID>"
}

# Create a PowerVS instance
resource "ibm_power_instance" "main" {
  name = "my-power-instance"
  # Image to use
  image = "ibm-power-aix-7.2"
  # Instance type
  instance_type = "power-e850c"
  # Availability zone
  availability_zone = "us-south-1"
  #  SSH Key
  ssh_key_name = "my-ssh-key"
  # Add tags to the instance
  tags = {
    Name = "My PowerVS Instance"
  }
}

  