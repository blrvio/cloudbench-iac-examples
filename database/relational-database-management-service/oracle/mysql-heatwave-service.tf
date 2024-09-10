
    # Configure the Oracle Cloud Infrastructure Provider
provider "oci" {
  # Set your tenancy OCID
  tenancy_ocid = "ocid1.tenancy.oc1..aaaaaaaaaaaaaaaaaaaaaaaaaaaa"
  # Set your user OCID
  user_ocid = "ocid1.user.oc1..aaaaaaaaaaaaaaaaaaaaaaaaaaaa"
  # Set your region
  region = "us-ashburn-1"
  # Set your compartment OCID
  compartment_id = "ocid1.compartment.oc1..aaaaaaaaaaaaaaaaaaaaaaaaaaaa"
}

# Create a MySQL Heatwave Cluster
resource "oci_mysql_heatwave_cluster" "main" {
  # Set a unique name for the cluster
  display_name = "my-heatwave-cluster"
  # Select the desired shape for the cluster
  shape = "VM.Standard.E4.Flex"
  # Set the network configuration
  subnet_id = "ocid1.subnet.oc1..aaaaaaaaaaaaaaaaaaaaaaaaaaaa"
  # Specify the MySQL database instance for the cluster
  mysql_database_id = "ocid1.mysql.database.oc1..aaaaaaaaaaaaaaaaaaaaaaaaaaaa"
}

# Create a MySQL Heatwave Node
resource "oci_mysql_heatwave_node" "main" {
  # Set a unique name for the node
  display_name = "my-heatwave-node"
  # Select the desired shape for the node
  shape = "VM.Standard.E4.Flex"
  # Specify the Heatwave cluster for the node
  heatwave_cluster_id = oci_mysql_heatwave_cluster.main.id
}

  