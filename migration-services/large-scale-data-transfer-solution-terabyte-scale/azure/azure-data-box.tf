
    # Configure the Azure Provider
provider "azurerm" {
  features {} # Enable all features
}

# Create a Data Box Disk resource
resource "azurerm_data_box_disk" "example" {
  name = "mydataboxdisk"
  location = "westus2"
  # Suppress long strings for the following
  #   transfer_specification - use a proper JSON object
  #   shipping_information - provide a reasonable value
  transfer_specification = "{}"
  shipping_information    = "{}"
  # Ensure that an address exists before proceeding
  #   shipping_address - provide a reasonable value
  shipping_address = "{}"
}

# Create a Data Box Edge resource
resource "azurerm_data_box_edge_device" "example" {
  name                    = "mydataboxedge"
  location                = "westus2"
  # Suppress long strings for the following
  #   shipping_address - provide a reasonable value
  shipping_address     = "{}"
  # Ensure that a network exists before proceeding
  #   network_configuration - provide a reasonable value
  network_configuration = "{}"
  # Suppress long strings for the following
  #   storage_account_configuration - use a proper JSON object
  storage_account_configuration = "{}"
}

# Create a Data Box Gateway resource
resource "azurerm_data_box_gateway" "example" {
  name                 = "mydataboxgateway"
  location             = "westus2"
  # Suppress long strings for the following
  #   resource_group_name - provide a reasonable value
  resource_group_name  = "{}"
  # Suppress long strings for the following
  #   network_configuration - provide a reasonable value
  network_configuration = "{}"
  # Ensure that an address exists before proceeding
  #   shipping_address - provide a reasonable value
  shipping_address     = "{}"
}

  