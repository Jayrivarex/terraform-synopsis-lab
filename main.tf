# Sufijo aleatorio para nombres globalmente únicos (ACR, APIM y SWA)
resource "random_string" "suffix" {
  length  = 6
  special = false
  upper   = false
}

# Referencia obligatoria al Grupo de Recursos existente del sandbox
data "azurerm_resource_group" "rg" {
  name = "1-75e47af0-playground-sandbox"
}

# 1. Azure Container Registry (ACR) - SKU Basic
resource "azurerm_container_registry" "acr" {
  name                = "acrsynopsis${random_string.suffix.result}"
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = data.azurerm_resource_group.rg.location
  sku                 = "Basic"
  admin_enabled       = true
}

# 2. Azure Kubernetes Service (AKS) - Con OIDC habilitado obligatoriamente
resource "azurerm_kubernetes_cluster" "aks" {
  name                = "aks-synopsis-dev"
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
  dns_prefix          = "akssynopsis-dev"

  default_node_pool {
    name       = "defaultpool"
    node_count = 2
    vm_size    = "Standard_D2s_v3"
  }

  identity {
    type = "SystemAssigned"
  }

  # Habilitamos OIDC de forma explícita para evitar el conflicto de estado
  oidc_issuer_enabled       = true
  workload_identity_enabled = true

  tags = {
    Environment = "dev"
    Project     = "Synopsis-Lab"
  }
}

# 3. Azure API Management (APIM) - SKU Consumption
resource "azurerm_api_management" "apim" {
  name                = "apim-synopsis-cons-${random_string.suffix.result}"
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
  publisher_name      = "Synopsis Interbank"
  publisher_email     = "devops-admin@synopsis.local"
  sku_name            = "Consumption_0"
}

# 4. Azure Static Web Apps (SWA) - Ubicado en una región compatible (eastus2)
resource "azurerm_static_web_app" "swa" {
  name                = "swa-synopsis-${random_string.suffix.result}"
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = "eastus2" # Región soportada por la API de Static Web Apps
  sku_tier            = "Standard"
  sku_size            = "Standard"
}