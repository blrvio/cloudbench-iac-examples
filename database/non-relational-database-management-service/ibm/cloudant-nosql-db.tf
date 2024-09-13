
      # Configure o provedor IBM Cloud
provider "ibm" {
  api_key = "YOUR_IBM_CLOUD_API_KEY" # Substitua pela sua API Key do IBM Cloud
  region  = "us-south" # Substitua pela sua região desejada
}

# Crie um banco de dados Cloudant
resource "ibm_cloudant_database" "my_database" {
  name = "my_database" # Substitua pelo nome do seu banco de dados
  db_type = "json"
}

# Crie um usuário Cloudant
resource "ibm_cloudant_user" "my_user" {
  username = "my_user" # Substitua pelo nome do seu usuário
  password = "my_password" # Substitua pela senha do seu usuário
}
    