
    # Configure the Huawei Cloud provider
provider "huaweicloud" {
  region = "cn-north-1" # Replace with your desired region
}

# Create a Data Express Service (DES) tunnel
resource "huaweicloud_des_tunnel" "main" {
  name           = "my-des-tunnel"
  description    = "A tunnel for data transfer"
  tunnel_type    = "vpc-to-vpc"
  bandwidth_type = "standard"
  bandwidth      = 100 # Mbps
  source_vpc_id    = "vpc-xxxxxxxxxxxxx" # Replace with your source VPC ID
  source_cidr     = "10.0.0.0/16" # Replace with your source CIDR
  destination_vpc_id = "vpc-xxxxxxxxxxxxx" # Replace with your destination VPC ID
  destination_cidr  = "10.1.0.0/16" # Replace with your destination CIDR
}

  