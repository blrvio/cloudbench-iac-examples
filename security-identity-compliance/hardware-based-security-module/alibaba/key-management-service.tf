
    # Configure the Alibaba Cloud Provider
provider "alicloud" {
  region  = "cn-hangzhou"
  # Add your credentials and other configurations
}

# Create a KMS Key
resource "alicloud_kms_key" "example" {
  description = "Example Key"
  # Other options for creating the key
}

# Encrypt a String
output "encrypted_string" {
  value = alicloud_kms_key.example.encrypt_data(plain_text = "hello world")
}

# Decrypt a String
output "decrypted_string" {
  value = alicloud_kms_key.example.decrypt_data(ciphertext = var.ciphertext)
}

# Define ciphertext for decryption
variable "ciphertext" {
  default = "your-ciphertext-value"
}
  