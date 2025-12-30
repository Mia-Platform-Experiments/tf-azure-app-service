# Azure App Service Terraform Module

This Terraform module provisions an Azure App Service with an App Service Plan, designed to simplify application deployment with performance-based configurations.

## Features

- **Performance Profiles**: Choose from `sandbox`, `development`, or `production` profiles that automatically map to appropriate Azure SKU tiers
- **Runtime Stack Support**: Supports Node.js 18 LTS and Python 3.10 (extensible for additional runtimes)
- **Linux-based**: Provisions Linux-based App Service Plans and Web Apps
- **CI/CD Ready**: Configured for code deployment via GitHub Actions or other CI/CD pipelines
- **Tagged Resources**: Automatic tagging for environment tracking and management

## Performance Profile Mapping

The module automatically maps performance profiles to Azure SKU tiers:

| Performance Profile | App Service Plan SKU | Description |
|---------------------|---------------------|-------------|
| `sandbox` | B1 (Basic) | Low-cost tier for testing and demos |
| `development` | S1 (Standard) | Auto-scale capable tier for development |
| `production` | P1v2 (Premium) | High-performance tier with advanced features |

## Usage

```hcl
module "app_service" {
  source = "./tf-azure-app-service"

  service_name         = "payment-service"
  resource_group_name  = "rg-myapp"
  location             = "eastus"
  performance_profile  = "production"
  tech_stack           = "Node.js 18 LTS"
  deployed_service     = "service-hello-world"
}
```

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.0 |
| azurerm | >= 3.0 |

## Providers

| Name | Version |
|------|---------|
| azurerm | >= 3.0 |

## Inputs

| Name | Description | Type | Required | Validation |
|------|-------------|------|----------|------------|
| `service_name` | The name of the service (e.g., payment-service). Used for resource naming. | `string` | Yes | - |
| `resource_group_name` | The name of the existing Resource Group in Azure. | `string` | Yes | - |
| `location` | The Azure region to deploy to. | `string` | Yes | - |
| `performance_profile` | The performance tier selected by the developer. | `string` | Yes | Must be one of: `sandbox`, `development`, `production` |
| `tech_stack` | The runtime stack for the application (e.g., "Node.js 18 LTS", "Python 3.10"). | `string` | Yes | - |
| `deployed_service` | Service to be deployed to this app. | `string` | Yes | - |

## Outputs

| Name | Description |
|------|-------------|
| `webapp_name` | The name of the Web App. The CI/CD pipeline needs this to deploy code. |
| `webapp_url` | The public URL of the deployed service. |
| `webapp_id` | The ID of the Web App. |
| `service_plan_id` | The ID of the App Service Plan. |
| `service_plan_name` | The name of the App Service Plan. |
| `default_hostname` | The default hostname of the Web App. |
| `deployed_service` | Service to be deployed to this app. |

## Resources Created

- `azurerm_service_plan`: App Service Plan with Linux OS and performance-based SKU
- `azurerm_linux_web_app`: Linux Web App with runtime stack configuration

## Example with Multiple Services

```hcl
# Development environment
module "dev_app" {
  source = "./tf-azure-app-service"

  service_name         = "api-service"
  resource_group_name  = "rg-dev"
  location             = "westus2"
  performance_profile  = "development"
  tech_stack           = "Python 3.10"
  deployed_service     = "api-backend"
}

# Production environment
module "prod_app" {
  source = "./tf-azure-app-service"

  service_name         = "api-service"
  resource_group_name  = "rg-prod"
  location             = "westus2"
  performance_profile  = "production"
  tech_stack           = "Node.js 18 LTS"
  deployed_service     = "api-backend"
}
```

## Notes

- The Web App is provisioned without code; application code should be deployed separately via CI/CD pipelines
- `SCM_DO_BUILD_DURING_DEPLOYMENT` is enabled to support build during deployment
- Resources are named using the pattern: `asp-{service_name}` for Service Plan and `app-{service_name}` for Web App
- All resources are tagged with environment and managed_by metadata

## License

See the main project LICENSE file for details.
