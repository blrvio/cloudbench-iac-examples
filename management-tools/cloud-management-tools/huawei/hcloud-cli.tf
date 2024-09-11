
    # Configure the HCloud provider
provider "hcloud" {
  token = "YOUR_HUAWEI_CLOUD_TOKEN" # Replace with your Huawei Cloud Token
  # Optional: Set the region
  region = "eu-central-1"
}

# Create a server
resource "hcloud_server" "main" {
  name       = "my-hcloud-server"
  image      = "hcloud:centos-7"
  location   = "fkb1"
  # Define the server's network
  network {
    # Select the network to attach to
    network = "hcloud:network-default"
  }
  # Define the server's storage
  storage {
    size = 20
    type = "HDD"
  }
}

# Create a floating IP
resource "hcloud_floating_ip" "main" {
  # This creates a floating IP in the default network
  network = "hcloud:network-default"
}

# Attach the floating IP to the server
resource "hcloud_server_floating_ip" "main" {
  server_id = hcloud_server.main.id
  floating_ip_id = hcloud_floating_ip.main.id
}

# Create a SSH key
resource "hcloud_ssh_key" "main" {
  name = "my-ssh-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCs..."
  # Replace with your public SSH key
}

# Associate the SSH key to the server
resource "hcloud_server_ssh_key" "main" {
  server_id = hcloud_server.main.id
  ssh_key_id = hcloud_ssh_key.main.id
}
  