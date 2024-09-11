
    # Configure the Huawei Cloud provider
provider "huaweicloud" {
  region = "eu-west-1" # Replace with your desired region
}

# Create a WPS instance
resource "huaweicloud_wps_instance" "main" {
  name     = "my-wps-instance"
  flavor   = "wps-1000"
  #  Specify an existing subnet for the instance
  subnet_id = "subnet-xxxxxxxx"
}

# Create a security group for the WPS instance
resource "huaweicloud_secgroup" "main" {
  name   = "my-wps-secgroup"
  # Allow inbound traffic on port 80 (HTTP) from any source
  ingress {
    protocol = "tcp"
    from_port = 80
    to_port   = 80
    cidr_blocks = ["0.0.0.0/0"]
  }
  # Allow outbound traffic on all ports to any destination
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

  