# 1. Map "T-Shirt Sizes" (Intent) to Azure SKUs (Technical)
locals {
  service_plan_sku_map = {
    sandbox     = "B1"    # Basic (Low cost)
    development = "S1"    # Standard (Auto-scale capable)
    production  = "P1v2"  # Premium (High performance)
  }
}

# 2. Create the App Service Plan (The "Compute")
resource "azurerm_service_plan" "main" {
  name                = "asp-${var.service_name}"
  location            = var.location
  resource_group_name = var.resource_group_name
  os_type             = "Linux"
  sku_name            = local.service_plan_sku_map[var.performance_profile]

  tags = {
    environment = var.performance_profile
    managed_by  = "terraform"
  }
}

# 3. Create the Web App (The "Container")
resource "azurerm_linux_web_app" "main" {
  name                = "app-${var.service_name}"
  location            = var.location
  resource_group_name = var.resource_group_name
  service_plan_id     = azurerm_service_plan.main.id

  site_config {
    # This configures the runtime (e.g., Node, Python) but deploys NO code.
    # The code will be deployed later by GitHub Actions.
    application_stack {
      node_version = var.tech_stack == "Node.js 18 LTS" ? "18-lts" : null
      python_version = var.tech_stack == "Python 3.10" ? "3.10" : null
      # Add more mappings here as needed
    }
  }

  tags = {
    service = var.service_name
  }
}