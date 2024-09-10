
    # Configure the IBM Cloud provider
provider "ibm" {
  region    = "us-south"
  api_key  = "YOUR_IBM_CLOUD_API_KEY"
  account_id = "YOUR_IBM_CLOUD_ACCOUNT_ID"
}

# Create a Watson Knowledge Studio project
resource "ibm_watson_knowledge_studio_project" "main" {
  name = "my-knowledge-studio-project"
  # Set optional project settings
  # description        = "My knowledge studio project"
  # training_data_type = "text"
  # training_data_format = "json"
}

# Create a Watson Knowledge Studio document collection
resource "ibm_watson_knowledge_studio_document_collection" "main" {
  project_id = ibm_watson_knowledge_studio_project.main.id
  name        = "my-document-collection"
}

# Create a Watson Knowledge Studio knowledge graph
resource "ibm_watson_knowledge_studio_knowledge_graph" "main" {
  project_id = ibm_watson_knowledge_studio_project.main.id
  name        = "my-knowledge-graph"
  # Set optional knowledge graph settings
  # description = "My knowledge graph"
}

# Create a Watson Knowledge Studio training dataset
resource "ibm_watson_knowledge_studio_training_dataset" "main" {
  project_id = ibm_watson_knowledge_studio_project.main.id
  name        = "my-training-dataset"
  # Set optional training dataset settings
  # description = "My training dataset"
}

# Create a Watson Knowledge Studio label set
resource "ibm_watson_knowledge_studio_label_set" "main" {
  project_id = ibm_watson_knowledge_studio_project.main.id
  name        = "my-label-set"
  # Set optional label set settings
  # description = "My label set"
}

# Create a Watson Knowledge Studio document
resource "ibm_watson_knowledge_studio_document" "main" {
  project_id      = ibm_watson_knowledge_studio_project.main.id
  document_collection_id = ibm_watson_knowledge_studio_document_collection.main.id
  content          = "This is my document."
  # Set optional document settings
  # description      = "My document"
  # source           = "my-source"
}

  