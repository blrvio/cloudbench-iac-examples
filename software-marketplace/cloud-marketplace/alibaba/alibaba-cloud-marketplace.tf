
      # Configure o provedor do Alibaba Cloud
provider "alicloud" {
  region = "cn-hangzhou" # Substitua pela sua região desejada
}

# Crie uma lista de produtos de marketplace
resource "alicloud_marketplace_product_list" "example" {
  name = "example"
  description = "A list of marketplace products"
  product_ids = ["product-id-1", "product-id-2"]
  #  product_ids = ["product-id-1", "product-id-2", "product-id-3", "product-id-4", "product-id-5"]

  #  product_ids = ["product-id-1", "product-id-2", "product-id-3", "product-id-4", "product-id-5", "product-id-6", "product-id-7", "product-id-8", "product-id-9", "product-id-10", "product-id-11", "product-id-12"]
}

# Crie uma instância de produto do marketplace
resource "alicloud_marketplace_product_instance" "example" {
  product_id = "product-id"
  quantity    = 1
  parameters  = {
    #  key-1 = "value-1"
    #  key-2 = "value-2"
    key-3 = "value-3"
    #  key-4 = "value-4"
    #  key-5 = "value-5"
  }
  #  product_list_id = alicloud_marketplace_product_list.example.id
}

    