
    # Configure the Azure Provider
provider "azurerm" {
  features {} # This is needed to enable the Data Box resources
}

# Create a Data Box Disk order
resource "azurerm_data_box_disk_order" "example" {
  name                 = "example-disk-order"
  resource_group_name  = "example-resources"
  location              = "westus"
  shipping_address {
    address_type      = "business"
    country           = "US"
    state             = "WA"
    city              = "Seattle"
    street_address1   = "1 Microsoft Way"
    postal_code       = "98052"
    contact_person     = "John Doe"
    phone              = "555-555-5555"
    shipping_instructions = "Ship to the front desk"
  }
  # Choose the disks that will be shipped.
  disks {
    disk_type = "HDD"
    count      = 2
  }
  # These details are for the data box disk return.
  return_shipping_address {
    address_type     = "business"
    country          = "US"
    state            = "WA"
    city             = "Seattle"
    street_address1  = "1 Microsoft Way"
    postal_code      = "98052"
    contact_person   = "John Doe"
    phone            = "555-555-5555"
    shipping_instructions = "Ship to the front desk"
  }
  # Use the following tags for the data box order resource
  tags = {
    Environment = "Production"
  }
}

# Configure the location where the data box disk will be shipped
resource "azurerm_data_box_location" "example" {
  name                 = "example-data-box-disk-location"
  resource_group_name  = "example-resources"
  location              = "westus"
  data_box_disk_order_id = azurerm_data_box_disk_order.example.id
  # Shipping location details. Provide a valid address for shipping.
  shipping_address {
    address_type      = "business"
    country           = "US"
    state             = "WA"
    city              = "Seattle"
    street_address1   = "1 Microsoft Way"
    postal_code       = "98052"
    contact_person     = "John Doe"
    phone              = "555-555-5555"
    shipping_instructions = "Ship to the front desk"
  }
  # Use the following tags for the data box location resource
  tags = {
    Environment = "Production"
  }
}
  