# Define Provider
provider "azurerm" {
  features {}
}

# Define Resource Group
resource "azurerm_resource_group" "main" {
  name     = "${var.projectname}-resources"
  location = var.location

tags= {
  tagname="${var.projectname}-RG"
  }
}

# Define Public IP
resource "azurerm_public_ip" "main" {
  name                = "${var.projectname}-publicip"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  allocation_method   = "Static"

tags= {
  tagname="${var.projectname}-PubIP"
  }
}

# Define Virtual Network

resource "azurerm_virtual_network" "main" {
  name                = "${var.projectname}-network"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name

tags= {
  tagname="${var.projectname}-VirtualN"
  }

}

# Define Subnet 

resource "azurerm_subnet" "internal" {
  name                 = "${var.projectname}-internal"
  resource_group_name  = azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.main.name
  address_projectnamees     = ["10.0.2.0/24"]
}


# Define Security Group 

resource "azurerm_network_security_group" "main"{ 
  name                    = "${var.projectname}-nsg"
  location                = azurerm_resource_group.main.location
  resource_group_name     = azurerm_resource_group.main.name

  security_rule {

    name                       = "VM-Rule"
    priority                   = 200
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_projectname      = "VirtualNetwork"
    destination_address_projectname = "*"

  }

  security_rule {

    name                       = "DenyInternet"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Deny"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_projectname      = "*"
    destination_address_projectname = "*"

  }

tags= {
  tagname="${var.projectname}-Sec"
  }
}


# Define  NIC
resource "azurerm_network_interface" "main" {
  count                = var.vmnumber
  name                = "NIC-${count.index}"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location

  ip_configuration {
    name                          = "InternalConfig-${count.index}"
    subnet_id                     = azurerm_subnet.internal.id
    private_ip_address_allocation = "Dynamic"
  }

tags= {
  tagname="${var.projectname}-NIC"
  }

}

# Define Load Balancer

resource "azurerm_lb" "main" {
  name                = "${var.projectname}-balancer"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
#  sku                 = "standard"

frontend_ip_configuration {

  name                          = "PublicIp_front"
#  private_ip_address_allocation = "Static"
  public_ip_address_id          = azurerm_public_ip.main.id
}

tags= {
  tagname="${var.projectname}-LB"
  }

}

# Define Load Balancer Backend Address Pool 

resource "azurerm_lb_backend_address_pool" "main" {
  resource_group_name  = azurerm_resource_group.main.name 
  loadbalancer_id      = azurerm_lb.main.id
  name                 = "${var.projectname}-backendAdPool"

}


# Define VM Availability Set 

resource "azurerm_availability_set" "main" {
  count                        = var.vmnumber
  name                         = "VMAvSet-${count.index}"
  location                     = azurerm_resource_group.main.location
  resource_group_name          = azurerm_resource_group.main.name
  platform_fault_domain_count  = 2
  platform_update_domain_count = 2
  managed                      = true

tags= {
  tagname="${var.projectname}-VM-avail"
  }

}


# Define Virtual Machines 

resource "azurerm_linux_virtual_machine" "main" {
  count                           = var.vmnumber
  name                            = "vm-${count.index}"

  resource_group_name             = azurerm_resource_group.main.name
  location                        = azurerm_resource_group.main.location
  size                            = "Standard_D2_v3"
  admin_username                  = var.admin
  admin_password                  = var.password
  disable_password_authentication = false
  network_interface_ids           = [element(azurerm_network_interface.main.*.id, count.index)]
  source_image_id                 = var.image


  os_disk {
    name                 = "Disk-${count.index}"
    storage_account_type = "Standard_LRS"
    caching              = "ReadWrite"
  }

tags= {
  tagname="${var.projectname}-VM"
  }



}

# Define Managed Disk 

resource "azurerm_managed_disk" "main" {
  name                  = "${var.projectname}-Disk"
  location              = azurerm_resource_group.main.location
  resource_group_name   = azurerm_resource_group.main.name
  storage_account_type  = "Standard_LRS"
  disk_size_gb          = "1"
  create_option         = "Empty"

tags= {
  tagname="${var.projectname}-DiskM"
  }

  
}