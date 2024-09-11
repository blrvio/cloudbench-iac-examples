
    # Configure the Huawei Cloud provider
provider "huaweicloud" {
  region = "eu-west1"
}

# Create an EVS volume
resource "huaweicloud_evs_volume" "main" {
  availability_zone = "eu-west1a"
  capacity           = 100
  volume_type       = "SSD"
  name              = "my-evs-volume"
}

# Create a security group
resource "huaweicloud_vpc_security_group" "main" {
  name   = "my-security-group"
  vpc_id = "your_vpc_id"

  # Allow SSH access from anywhere
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Create an instance that will attach the EVS volume
resource "huaweicloud_ecs_instance" "main" {
  availability_zone = "eu-west1a"
  flavor            = "flavor_name"
  image_id          = "image_id"
  name              = "my-instance"
  security_groups   = [huaweicloud_vpc_security_group.main.id]

  # Attach the EVS volume to the instance
  volume_attach {
    device = "/dev/vda"
    volume_id = huaweicloud_evs_volume.main.id
  }
}
  