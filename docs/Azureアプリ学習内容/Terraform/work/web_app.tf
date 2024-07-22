resource "azurerm_linux_web_app" "webapp" {
  name                  = "mk-flask-webapp-${random_integer.ri.result}"
  location              = azurerm_resource_group.rg.location
  resource_group_name   = azurerm_resource_group.rg.name
  service_plan_id       = azurerm_service_plan.app_service_plan.id
  https_only            = true
  site_config { 
    minimum_tls_version = "1.2"
    always_on           = false
    application_stack {
      python_version = "3.12"
    }
  }
  app_settings = {
    "FUNCTION_APP_API_KEY" = data.azurerm_function_app_host_keys.api_key_data.default_function_key
  }
}
