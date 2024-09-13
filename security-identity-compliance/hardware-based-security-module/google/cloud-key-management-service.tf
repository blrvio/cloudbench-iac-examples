
      # Configure o provedor AWS
provider "aws" {
  region = "us-east-1" # Substitua pela sua região desejada
}

# Crie uma chave KMS
resource "aws_kms_key" "default" {
  description = "Chave KMS para exemplo"
  deletion_window_in_days = 7 # Tempo de espera para exclusão (opcional)
  enable_key_rotation = true # Habilita a rotação automática da chave (opcional)
}

# Use a chave KMS para criptografar dados
resource "aws_kms_ciphertext" "encrypted_data" {
  ciphertext_blob = "your-data-to-encrypt"
  key_id = aws_kms_key.default.key_id
}

# Descifre dados usando a chave KMS
resource "aws_kms_plaintext" "decrypted_data" {
  ciphertext_blob = aws_kms_ciphertext.encrypted_data.ciphertext_blob
  key_id = aws_kms_key.default.key_id
}
    