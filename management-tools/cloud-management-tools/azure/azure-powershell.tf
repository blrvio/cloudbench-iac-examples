
    # Install the Azure PowerShell module
Install-Module -Name Az -Scope CurrentUser -Force

# Connect to Azure
Connect-AzAccount

# Create a resource group
New-AzResourceGroup -Name 'myResourceGroup' -Location 'eastus'

# Create a virtual machine
New-AzVM -ResourceGroupName 'myResourceGroup' -Name 'myVM' -Location 'eastus' -VirtualNetworkName 'myVNet' -SubnetName 'mySubnet' -PublicIpAddressName 'myPublicIP' -Size 'Standard_A2_v2' -OsType Linux -ProvisionVMAgent True -OpenSSHPublicKey 'ssh-rsa AAAAB3NzaC1yc2EAAAAB...'

# Start the virtual machine
Start-AzVM -ResourceGroupName 'myResourceGroup' -Name 'myVM'

  