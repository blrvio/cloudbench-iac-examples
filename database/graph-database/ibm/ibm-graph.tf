
      # Configure o provedor IBM Cloud
provider "ibm" {
  api_key = "your-api-key" # Substitua pela sua API key
  region = "us-south" # Substitua pela sua região desejada
}

# Crie um serviço IBM Graph
resource "ibm_cloudant_instance" "my_graph_db" {
  name = "my-graph-db"
  plan = "free"
}

# Crie um banco de dados
resource "ibm_cloudant_database" "my_graph_db_database" {
  instance_id = ibm_cloudant_instance.my_graph_db.id
  name = "my-graph-db-database"
}

# Crie um índice para o banco de dados
resource "ibm_cloudant_index" "my_graph_db_index" {
  instance_id = ibm_cloudant_instance.my_graph_db.id
  database_name = ibm_cloudant_database.my_graph_db_database.name
  name = "my-graph-db-index"
  index_definition = <<EOF
  {
    "index": {
      "fields": [ "_id", "_rev" ],
      "name": "my-graph-db-index"
    },
    "type": "json",
    "partial_filter_selector": {
      "_id": {
        "$gt": null
      }
    }
  }
  EOF
}

    