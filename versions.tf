terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }

  # CONNECTS TO YOUR HCP WORKSPACE
  # Since you created a "CLI-Driven" workspace, this block is required here.
  cloud {
    organization = "mia-platform"

    workspaces {
      name = "hcp-terraform-demo"
    }
  }
}

provider "azurerm" {
  features {}
}