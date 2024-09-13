
      # Configure o provedor do IBM Cloud
provider "ibm" {
  api_key = "YOUR_API_KEY" # Substitua pela sua API key
  region  = "us-south" # Substitua pela sua região desejada
}

# Crie um catálogo de conhecimento
resource "ibm_watson_knowledge_catalog_catalog" "my_catalog" {
  name = "my_catalog"
  description = "My knowledge catalog"
}

# Crie um conjunto de dados
resource "ibm_watson_knowledge_catalog_data_asset" "my_data_asset" {
  catalog_id = ibm_watson_knowledge_catalog_catalog.my_catalog.id
  name = "my_data_asset"
  description = "My data asset"
}

# Adicione um esquema ao conjunto de dados
resource "ibm_watson_knowledge_catalog_data_asset_schema" "my_data_asset_schema" {
  data_asset_id = ibm_watson_knowledge_catalog_data_asset.my_data_asset.id
  schema = <<SCHEMA
  {
    "fields": [
      {
        "name": "name",
        "type": "string"
      },
      {
        "name": "age",
        "type": "integer"
      }
    ]
  }
SCHEMA
}

    