
    # Configure the Alibaba Cloud Provider
provider "alicloud" {
  region = "cn-hangzhou"
}

# Create a KMS Key
resource "alicloud_kms_key" "main" {
  key_usage = "ENCRYPT_DECRYPT"
  description = "My KMS Key"
  key_spec  = "AES_256"
}

# Create a KMS Key Version
resource "alicloud_kms_key_version" "main" {
  key_id = alicloud_kms_key.main.id
  enabled = true
}

# Create a KMS Alias
resource "alicloud_kms_alias" "main" {
  name = "MyKMSAlias"
  key_id = alicloud_kms_key.main.id
}

  