output "webapp_name" {
  description = "The name of the Web App. The CI/CD pipeline needs this to deploy code."
  value       = azurerm_linux_web_app.main.name
}

output "webapp_url" {
  description = "The public URL of the deployed service."
  value       = "https://${azurerm_linux_web_app.main.default_hostname}"
}