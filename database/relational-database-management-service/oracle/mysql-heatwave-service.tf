
    # Configure the Oracle Cloud Infrastructure Provider
provider "oci" {
  # Replace with your Oracle Cloud Infrastructure configuration
  region = "us-ashburn-1"
  tenancy_id = "ocid1.tenancy.oc1..aaaaaaaabq757j5x577s64n7k347uodg277j4u544w"
  user_ocid = "ocid1.user.oc1..aaaaaaaahw3x74y7t4m2r62r32t46r6n25i6l73m"
  fingerprint = "~/.oci/config"
}

# Create a MySQL Heatwave Cluster
resource "oci_mysql_heatwave_cluster" "main" {
  display_name = "my-heatwave-cluster"
  compartment_id = "ocid1.compartment.oc1..aaaaaaaavw77b5kqy6l4o47vtv777s7j3j4q5w"
  # Replace with the correct MySQL Database instance OCID
  mysql_db_instance_id = "ocid1.mysql.database.oc1..aaaaaaaabq5l53j7i2l7w7v7l2h6q2t6l576q"
  # Configure the Heatwave cluster with the desired resources
  heatwave_cluster_shape = "BM.H2.1"
  # Specify the size of the Heatwave cluster
  heatwave_cluster_size = 2
}

# Create a Heatwave Node
resource "oci_mysql_heatwave_node" "main" {
  display_name = "my-heatwave-node"
  # Replace with the correct Heatwave Cluster OCID
  heatwave_cluster_id = oci_mysql_heatwave_cluster.main.id
  # Specify the shape for the Heatwave node
  heatwave_node_shape = "BM.H2.1"
}

  