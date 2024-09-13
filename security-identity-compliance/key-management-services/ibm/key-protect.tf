
      # Configure o provedor IBM Cloud
provider "ibm" {
  api_key = "YOUR_API_KEY"
  region   = "us-south"
}

# Crie um serviço de Key Protect
resource "ibm_key_protect_instance" "key_protect_instance" {
  name    = "key-protect-instance"
  resource_group = "YOUR_RESOURCE_GROUP"
  location = "us-south"
}

# Crie uma chave criptográfica
resource "ibm_key_protect_key" "my_key" {
  name            = "my-key"
  instance_id     = ibm_key_protect_instance.key_protect_instance.id
  key_type        = "SYMMETRIC"
  algorithm       = "AES_256"
  key_usage       = "ENCRYPT_DECRYPT"
  rotation_policy = "AUTOMATIC"
}
    