
      ## Configure IBM Cloud Provider
provider "ibm" {
  api_key = "YOUR_IBM_CLOUD_API_KEY" # Replace with your IBM Cloud API Key
  region  = "us-south" # Replace with your desired region
}

## Configure Watson Discovery Service
resource "ibm_discovery_environment" "default" {
  name    = "my-discovery-environment" # Replace with your desired environment name
  version = "v1"
  plan = "lite"
}

## Create a Configuration
resource "ibm_discovery_configuration" "my-configuration" {
  name    = "my-configuration"
  environment_id = ibm_discovery_environment.default.id

  source {
    type = "file"
    file {
      bucket  = "my-bucket" # Replace with your IBM Cloud Object Storage bucket name
      key     = "my-data.csv" # Replace with your data file in Object Storage
      encoding = "UTF-8"
    }
  }
}

## Create a Collection
resource "ibm_discovery_collection" "my-collection" {
  name    = "my-collection"
  environment_id = ibm_discovery_environment.default.id
  configuration_id = ibm_discovery_configuration.my-configuration.id

  enrichments {
    natural_language_understanding {
      enabled = true
      features {
        entities {
          enabled = true
          sentiment {
            enabled = true
          }
        }
      }
    }
  }
}

## Create a Query
resource "ibm_discovery_query" "my-query" {
  environment_id = ibm_discovery_environment.default.id
  collection_id = ibm_discovery_collection.my-collection.id
  query = "query text"
}
    