
    # Configure the IBM Cloud provider
provider "ibm" {
  region  = "us-south"
  account_id = "your-ibm-cloud-account-id"
  api_key = "your-ibm-cloud-api-key"
}

# Create an Elasticsearch service instance
resource "ibm_elasticsearch" "main" {
  name            = "my-elasticsearch-instance"
  plan            = "standard-100"
  zone            = "us-south-1"
  service_name    = "databases-for-elasticsearch"
  # You can configure the Elasticsearch instance further by setting additional attributes, 
  # for example, the number of nodes, the memory size, or the version of Elasticsearch.
}

# Create a security group for your Elasticsearch instance
resource "ibm_security_group" "main" {
  name     = "my-elasticsearch-security-group"
  network  = "public"
  location = "us-south"

  # Define the ingress and egress rules for the security group.
  rule {
    direction = "inbound"
    protocol  = "tcp"
    port_range = "9200-9200"
    cidr       = "0.0.0.0/0"
  }
  rule {
    direction = "outbound"
    protocol  = "tcp"
    port_range = "0-65535"
    cidr       = "0.0.0.0/0"
  }
}

# Associate the security group with your Elasticsearch instance
resource "ibm_elasticsearch_security_group" "main" {
  elasticsearch_id = ibm_elasticsearch.main.id
  security_group_id = ibm_security_group.main.id
}

  