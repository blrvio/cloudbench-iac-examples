
    # Configure the Azure Provider
provider "azurerm" {
  features {}  # Enable all features
}

# Create a Resource Group
resource "azurerm_resource_group" "example" {
  name     = "example-rg"
  location = "westus2"
}

# Create a Virtual Network
resource "azurerm_virtual_network" "example" {
  name                = "example-vnet"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  address_space       = ["10.0.0.0/16"]
}

# Create a Subnet
resource "azurerm_subnet" "example" {
  name                 = "example-subnet"
  resource_group_name  = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = ["10.0.1.0/24"]
}

# Create a Linux VM
resource "azurerm_linux_virtual_machine" "example" {
  name                = "example-vm"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  size                = "Standard_A2_v2"
  network_interface_ids = [azurerm_network_interface.example.id]
  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "Latest"
  }
  os_disk {
    caching       = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  # Configure SSH key for access
  # Replace "your-ssh-key-public-key" with your SSH public key
  # ssh_key {
  #   public_key = "your-ssh-key-public-key"
  # }
}

# Create a Network Interface
resource "azurerm_network_interface" "example" {
  name                = "example-nic"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  # Connect the network interface to the subnet
  subnet_id = azurerm_subnet.example.id
}

# Create a Storage Account
resource "azurerm_storage_account" "example" {
  name                     = "example-storage"
  resource_group_name       = azurerm_resource_group.example.name
  location                 = azurerm_resource_group.example.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

# Configure the VM's storage
resource "azurerm_virtual_machine_data_disk" "example" {
  name                = "example-disk"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  virtual_machine_id  = azurerm_linux_virtual_machine.example.id
  caching            = "ReadWrite"
  disk_size_gb        = 100
  storage_account_type = "Standard_LRS"
  # You can use a managed disk by setting the following
  # managed_disk_type  = "Standard_LRS"
}

# Configure the VM's network configuration
resource "azurerm_network_interface" "example" {
  name                = "example-nic"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  # Connect the network interface to the subnet
  subnet_id = azurerm_subnet.example.id
}

# Configure the VM's OS disk
resource "azurerm_virtual_machine_os_disk" "example" {
  caching            = "ReadWrite"
  disk_size_gb        = 100
  storage_account_type = "Standard_LRS"
  # You can use a managed disk by setting the following
  # managed_disk_type  = "Standard_LRS"
}

# Configure the VM's network interface association
resource "azurerm_network_interface_association" "example" {
  network_interface_id = azurerm_network_interface.example.id
  virtual_machine_id   = azurerm_linux_virtual_machine.example.id
}

# Configure the VM's data disk association
resource "azurerm_virtual_machine_data_disk_attachment" "example" {
  disk_name        = azurerm_virtual_machine_data_disk.example.name
  virtual_machine_id = azurerm_linux_virtual_machine.example.id
}

# Configure the VM's operating system
resource "azurerm_virtual_machine_extension" "example" {
  name                = "CustomScriptExtension"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  virtual_machine_name = azurerm_linux_virtual_machine.example.name
  publisher           = "Microsoft.Compute"
  type                = "CustomScriptExtension"
  # Replace "your-script" with your script to configure the VM
  settings = {
    # "your-script"
  }
  protected_settings = {
    # "your-script"
  }
}

# Configure the VM's network interface association
resource "azurerm_network_interface_association" "example" {
  network_interface_id = azurerm_network_interface.example.id
  virtual_machine_id   = azurerm_linux_virtual_machine.example.id
}

# Configure the VM's data disk association
resource "azurerm_virtual_machine_data_disk_attachment" "example" {
  disk_name        = azurerm_virtual_machine_data_disk.example.name
  virtual_machine_id = azurerm_linux_virtual_machine.example.id
}

# Configure the VM's operating system
resource "azurerm_virtual_machine_extension" "example" {
  name                = "CustomScriptExtension"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  virtual_machine_name = azurerm_linux_virtual_machine.example.id
  publisher           = "Microsoft.Compute"
  type                = "CustomScriptExtension"
  # Replace "your-script" with your script to configure the VM
  settings = {
    # "your-script"
  }
  protected_settings = {
    # "your-script"
  }
}
  