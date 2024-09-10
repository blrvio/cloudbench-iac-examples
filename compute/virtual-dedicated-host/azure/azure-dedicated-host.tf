
    # Configure the Azure Provider
provider "azurerm" {
  features {} # Enable all features, including support for dedicated hosts
}

# Create a Dedicated Host Group
resource "azurerm_dedicated_host_group" "example" {
  name                 = "example-host-group"
  location             = "westus2"
  resource_group_name = "example-resources"
  # You can specify the host SKU here, or let Azure choose based on the VM size
  # host_sku             = "Standard_D2s_v3"
}

# Create a Dedicated Host
resource "azurerm_dedicated_host" "example" {
  name                 = "example-host"
  host_group_name     = azurerm_dedicated_host_group.example.name
  location             = "westus2"
  resource_group_name = "example-resources"
  # You can specify the host SKU here, or let Azure choose based on the VM size
  # host_sku             = "Standard_D2s_v3"
}

# Create a Virtual Machine on a Dedicated Host
resource "azurerm_linux_virtual_machine" "example" {
  name                 = "example-vm"
  location             = "westus2"
  resource_group_name = "example-resources"
  size                 = "Standard_D2s_v3"
  # Specify the Dedicated Host to place the VM on
  dedicated_host_id = azurerm_dedicated_host.example.id
  network_interface {
    name = "example-nic"
    # Configure network interface settings here
  }
  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "Latest"
  }
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
}

  