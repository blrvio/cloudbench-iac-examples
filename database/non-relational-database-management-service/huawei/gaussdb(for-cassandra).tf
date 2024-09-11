
    # Configure the Huawei Cloud provider
provider "huaweicloud" {
  region = "cn-north-1" # Replace with your desired region
}

# Create a GaussDB(for Cassandra) cluster
resource "huaweicloud_gaussdb_for_cassandra_cluster" "main" {
  name              = "my-gaussdb-for-cassandra-cluster"
  cluster_version   = "3.0"
  cluster_type      = "basic"
  zone              = "cn-north-1-a"
  node_count        = 3
  instance_type     = "c1.xlarge"
  storage_type      = "SSD"
  storage_capacity   = 100
  maintenance_window = "00:00-02:00"

  # Optional settings for security groups
  security_groups = ["sg-00000000"] # Replace with your security group IDs

  # Optional settings for encryption
  encryption_at_rest_enabled = true

  # Optional settings for backup
  backup_policy {
    backup_frequency = "daily"
    backup_retention_days = 7
  }
}

# Create a GaussDB(for Cassandra) user
resource "huaweicloud_gaussdb_for_cassandra_user" "main" {
  cluster_id = huaweicloud_gaussdb_for_cassandra_cluster.main.id
  name         = "my-gaussdb-for-cassandra-user"
  password      = "my-password"
}

# Create a GaussDB(for Cassandra) keyspace
resource "huaweicloud_gaussdb_for_cassandra_keyspace" "main" {
  cluster_id = huaweicloud_gaussdb_for_cassandra_cluster.main.id
  name         = "my-keyspace"
}

# Create a GaussDB(for Cassandra) table
resource "huaweicloud_gaussdb_for_cassandra_table" "main" {
  cluster_id = huaweicloud_gaussdb_for_cassandra_cluster.main.id
  keyspace   = "my-keyspace"
  name        = "my-table"
  columns     = [
    {
      name      = "id"
      type      = "int"
      is_primary = true
    },
    {
      name = "name"
      type = "text"
    }
  ]
}

  