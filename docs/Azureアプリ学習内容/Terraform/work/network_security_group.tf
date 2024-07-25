
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

resource "azurerm_network_security_group" "gateway_nsg" {
  name                = "mk-gateway_app-security-group-${random_integer.ri.result}"
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