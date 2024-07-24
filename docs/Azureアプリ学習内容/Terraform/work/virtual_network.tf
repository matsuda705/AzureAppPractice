resource "azurerm_virtual_network" "vnet" {
  name                = "web-app-network-${random_integer.ri.result}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = ["10.0.0.0/16"]
  dns_servers         = ["10.0.0.4", "10.0.0.5"]

  tags = {
    environment = "Production"
  }
}

resource "azurerm_subnet" "webAppSubnet" {
  name                 = "webAppSubnet-${random_integer.ri.result}"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]
  delegation {
    name = "Delegation"
    service_delegation {
      name = "Microsoft.Web/serverFarms"
    }
  }
}

resource "azurerm_subnet" "funcAppSubnet" {
  name                 = "funcAppSubnet-${random_integer.ri.result}"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.2.0/24"]
  delegation {
    name = "Delegation"
    service_delegation {
      name = "Microsoft.Web/serverFarms"
    }
  }
}

resource "azurerm_network_security_group" "func_nsg" {
  name                = "mk-func_app-security-group-${random_integer.ri.result}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_network_security_group" "web_nsg" {
  name                = "mk-web_app-security-group-${random_integer.ri.result}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_subnet_network_security_group_association" "funcNsgConnection" {
  subnet_id                 = azurerm_subnet.funcAppSubnet.id
  network_security_group_id = azurerm_network_security_group.func_nsg.id
}

resource "azurerm_subnet_network_security_group_association" "webNsgConnection" {
  subnet_id                 = azurerm_subnet.webAppSubnet.id
  network_security_group_id = azurerm_network_security_group.web_nsg.id
}

resource "azurerm_network_security_rule" "web_IP_nsr" {
  name                       = "AllowJBSIP"
  priority                   = 100
  direction                  = "Inbound"
  access                     = "Allow"
  protocol                   = "*"
  source_port_range          = "*"
  destination_port_range     = "*"
  source_address_prefix      = "221.248.64.0/24"
  destination_address_prefix = "*"
  resource_group_name         = azurerm_resource_group.rg.name
  network_security_group_name = azurerm_network_security_group.web_nsg.name
}