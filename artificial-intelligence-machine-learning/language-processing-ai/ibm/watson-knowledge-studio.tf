
      # Configure o provedor do IBM Cloud
provider "ibm" {
  api_key = "YOUR_IBM_CLOUD_API_KEY"
  region  = "us-south"
}

# Crie um projeto do Watson Knowledge Studio
resource "ibm_knowledge_studio_project" "example" {
  name     = "my-knowledge-studio-project"
  location = "us-south"
  # O atributo 'description' pode ser configurado com uma descrição do projeto.
}

# Crie um conjunto de dados do Watson Knowledge Studio
resource "ibm_knowledge_studio_dataset" "example" {
  project_id  = ibm_knowledge_studio_project.example.id
  name       = "my-knowledge-studio-dataset"
  # O atributo 'description' pode ser configurado com uma descrição do conjunto de dados.
  # O atributo 'data_source' pode ser configurado com um fonte de dados para o conjunto de dados.
}

# Crie um modelo de conhecimento do Watson Knowledge Studio
resource "ibm_knowledge_studio_knowledge_model" "example" {
  dataset_id   = ibm_knowledge_studio_dataset.example.id
  name          = "my-knowledge-studio-knowledge-model"
  # O atributo 'description' pode ser configurado com uma descrição do modelo de conhecimento.
  # O atributo 'training_data' pode ser configurado com dados de treinamento para o modelo de conhecimento.
}

# Crie um endpoint do Watson Knowledge Studio
resource "ibm_knowledge_studio_endpoint" "example" {
  knowledge_model_id = ibm_knowledge_studio_knowledge_model.example.id
  name               = "my-knowledge-studio-endpoint"
  # O atributo 'description' pode ser configurado com uma descrição do endpoint.
  # O atributo 'runtime_options' pode ser configurado com opções de runtime para o endpoint.
}
    