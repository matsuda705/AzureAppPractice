resource "azurerm_static_web_app" "swaApp" {
  name = "swaApp-${random_integer.ri.result}"
  resource_group_name = azurerm_resource_group.rg.name
  location = "eastasia"
}

# Azure Static Web App の API キー を出力する（センシティブ有効）
output "swa_api_key" {
  value = azurerm_static_web_app.swaApp.api_key
  sensitive = true
}