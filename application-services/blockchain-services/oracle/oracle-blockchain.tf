
    # Configure the Oracle Cloud provider
provider "oci" {
  region  = "us-ashburn-1"
  tenancy = "ocid1.tenancy.oc1..aaaaaaaaaaaaaa"
  user    = "ocid1.user.oc1..aaaaaaaaaaaaaa"
  key_file = "~/.oci/config"
}

# Create a Blockchain Platform
resource "oci_blockchain_platform" "main" {
  display_name = "My Blockchain Platform"
  compartment_id = "ocid1.compartment.oc1..aaaaaaaaaaaaaa"
  # Specify the platform type, such as "consortium" for a multi-organization network
  platform_type = "consortium"
}

# Create a peer node for the Blockchain Platform
resource "oci_blockchain_peer_node" "main" {
  display_name = "My Peer Node"
  platform_id  = oci_blockchain_platform.main.id
  # Specify the node type, such as "consensus" for a node that participates in consensus
  node_type = "consensus"
  compartment_id = "ocid1.compartment.oc1..aaaaaaaaaaaaaa"
}

# Create a channel for the Blockchain Platform
resource "oci_blockchain_channel" "main" {
  display_name = "My Channel"
  platform_id  = oci_blockchain_platform.main.id
  # Specify the channel type, such as "application" for a channel used by applications
  channel_type = "application"
  compartment_id = "ocid1.compartment.oc1..aaaaaaaaaaaaaa"
}

# Join a channel on the Blockchain Platform
resource "oci_blockchain_peer_node_channel" "main" {
  peer_node_id = oci_blockchain_peer_node.main.id
  channel_id    = oci_blockchain_channel.main.id
}

  