
    # Configure the Azure Provider
provider "azurerm" {
  features {} # Enable features for the provider
}

# Create a Managed Disk
resource "azurerm_managed_disk" "example" {
  name                 = "example-disk"
  location             = "westus2"
  resource_group_name = "example-resources"
  disk_size_gb        = 1023
  storage_account_type = "Standard_LRS"
  # You can optionally add tags to the disk.
  tags = {
    Name = "Example Disk"
  }
}

# Create a Virtual Machine
resource "azurerm_linux_virtual_machine" "example" {
  name                 = "example-vm"
  location             = "westus2"
  resource_group_name = "example-resources"
  size                 = "Standard_B2s"
  # Use the previously created managed disk
  os_disk {
    caching             = "ReadWrite"
    storage_account_type = "Standard_LRS"
    disk_size_gb        = 1023
    managed_disk_type  = "Standard"
    disk_id            = azurerm_managed_disk.example.id
  }
  network_interface_ids = [azurerm_network_interface.example.id]
  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "Latest"
  }
  # You can optionally add tags to the virtual machine.
  tags = {
    Name = "Example VM"
  }
}

# Create a Network Interface
resource "azurerm_network_interface" "example" {
  name                 = "example-nic"
  location             = "westus2"
  resource_group_name = "example-resources"
  # Use the default subnet
  subnet_id = azurerm_subnet.example.id
  # You can optionally add tags to the network interface.
  tags = {
    Name = "Example NIC"
  }
}

# Create a Virtual Network
resource "azurerm_virtual_network" "example" {
  name                 = "example-vnet"
  location             = "westus2"
  resource_group_name = "example-resources"
  address_space        = ["10.0.0.0/16"]
  # You can optionally add tags to the virtual network.
  tags = {
    Name = "Example VNet"
  }
}

# Create a Subnet
resource "azurerm_subnet" "example" {
  name                 = "example-subnet"
  resource_group_name = "example-resources"
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes      = ["10.0.1.0/24"]
  # You can optionally add tags to the subnet.
  tags = {
    Name = "Example Subnet"
  }
}

# Create a Resource Group
resource "azurerm_resource_group" "example" {
  name     = "example-resources"
  location = "westus2"
  # You can optionally add tags to the resource group.
  tags = {
    Name = "Example Resource Group"
  }
}
  