
    # Configure the IBM Cloud provider
provider "ibm" {
  api_key = "your_ibm_cloud_api_key" # Replace with your IBM Cloud API key
  region  = "us-south" # Replace with the desired region
}

# Create a Watson Discovery collection
resource "ibm_discovery_collection" "main" {
  name = "my-discovery-collection"
  # Add configuration for the collection
  configuration {
    # Define the conversion settings for the collection
    conversion {
      # Define the format to convert documents to
      document_conversion {
        # Convert to PDF format
        pdf {
          # Enable OCR for PDF documents
          ocr = true
        }
      }
    }
    # Enable enrichment for the collection
    enrichment {
      # Enable all available enrichments
      all_enrichment = true
    }
  }
}

# Create a Watson Discovery environment
resource "ibm_discovery_environment" "main" {
  name = "my-discovery-environment"
  # Specify the collection to be used for the environment
  collection_id = ibm_discovery_collection.main.id
}

# Create a Watson Discovery document
resource "ibm_discovery_document" "main" {
  environment_id = ibm_discovery_environment.main.id
  # Define the document's metadata
  metadata {
    # Specify the document's type
    doc_type = "my-document-type"
  }
  # Upload the document to the environment
  file = "path/to/your/document.txt"
}

  