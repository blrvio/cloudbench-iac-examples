
    # Configure the Azure Provider
provider "azurerm" {
  features {} # Enable all features
}

# Create a Windows VM
resource "azurerm_windows_virtual_machine" "main" {
  name                = "my-windows-vm"
  location            = "westus2"
  resource_group_name = "my-resource-group"
  size                = "Standard_B2s"
  admin_username      = "my-admin-user"
  admin_password      = "P@$$wOrd"
  network_interface_ids = [azurerm_network_interface.main.id]
  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku      = "2019-Datacenter"
    version   = "latest"
  }
}

# Create a Network Interface
resource "azurerm_network_interface" "main" {
  name                = "my-network-interface"
  location            = "westus2"
  resource_group_name = "my-resource-group"
  # Connect the network interface to a virtual network
  virtual_network_id = azurerm_virtual_network.main.id
  # Connect the network interface to a subnet
  subnet_id = azurerm_subnet.main.id
}

# Create a Virtual Network
resource "azurerm_virtual_network" "main" {
  name                = "my-virtual-network"
  location            = "westus2"
  resource_group_name = "my-resource-group"
  address_space       = ["10.0.0.0/16"]
}

# Create a Subnet
resource "azurerm_subnet" "main" {
  name                 = "my-subnet"
  resource_group_name = "my-resource-group"
  virtual_network_name = "my-virtual-network"
  address_prefixes     = ["10.0.1.0/24"]
}

# Create a VM Extension
resource "azurerm_virtual_machine_extension" "main" {
  name                = "my-vm-extension"
  location            = "westus2"
  resource_group_name = "my-resource-group"
  virtual_machine_name = "my-windows-vm"
  publisher           = "Microsoft.Compute"
  type                = "CustomScriptExtension"
  # The type of VM Extension.
  # The "CustomScriptExtension" is used to run a custom script on the VM.
  # See https://docs.microsoft.com/azure/virtual-machines/virtual-machines-windows-extensions-features
  # for more information on available extensions.
  settings = <<EOF
  {
    "commandToExecute": "powershell -Command "Write-Output "Hello from VM Extension!" > C:\temp\hello.txt""
  }
EOF
}

  