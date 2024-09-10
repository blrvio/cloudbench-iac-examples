
    # Configure the IBM Cloud provider
provider "ibm" {
  # Replace with your IBM Cloud API key
  api_key = "YOUR_API_KEY"
}

# Create a Watson Knowledge Catalog service instance
resource "ibm_watson_knowledge_catalog_service_instance" "main" {
  name = "my-watson-knowledge-catalog"
  # Choose a plan, for example: "lite"
  plan = "lite"
  # Choose a region, for example: "us-south"
  region = "us-south"
}

# Create a Watson Knowledge Catalog data asset
resource "ibm_watson_knowledge_catalog_data_asset" "main" {
  # Replace with your data asset's unique identifier
  id = "YOUR_DATA_ASSET_ID"
  name = "my-data-asset"
  # Choose a data asset type, for example: "table"
  type = "table"
  # Choose a data asset category, for example: "sales"
  category = "sales"
  # Choose a data asset source, for example: "cloudant"
  source = "cloudant"
  # Add tags to the data asset
  tags = {
    "key1" = "value1"
    "key2" = "value2"
  }
  # Add a description for the data asset
  description = "This is my data asset"
  # Add a connection to the data asset
  connection {
    # Replace with your connection's unique identifier
    id = "YOUR_CONNECTION_ID"
  }
  # Add a lineage to the data asset
  lineage {
    # Replace with your lineage's unique identifier
    id = "YOUR_LINEAGE_ID"
  }
  # Add a glossary to the data asset
  glossary {
    # Replace with your glossary's unique identifier
    id = "YOUR_GLOSSARY_ID"
  }
}

  