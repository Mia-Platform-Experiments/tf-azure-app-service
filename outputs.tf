output "webapp_name" {
  description = "The name of the Web App. The CI/CD pipeline needs this to deploy code."
  value       = azurerm_linux_web_app.main.name
}

output "webapp_url" {
  description = "The public URL of the deployed service."
  value       = "https://${azurerm_linux_web_app.main.default_hostname}"
}

output "webapp_id" {
  description = "The ID of the Web App."
  value       = azurerm_linux_web_app.main.id
}

output "service_plan_id" {
  description = "The ID of the App Service Plan."
  value       = azurerm_service_plan.main.id
}

output "service_plan_name" {
  description = "The name of the App Service Plan."
  value       = azurerm_service_plan.main.name
}

output "default_hostname" {
  description = "The default hostname of the Web App."
  value       = azurerm_linux_web_app.main.default_hostname
}