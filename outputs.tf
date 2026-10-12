output "acr_login_server" {
  value       = azurerm_container_registry.acr.login_server
  description = "URL del servidor de registro del ACR"
}

output "aks_cluster_name" {
  value       = azurerm_kubernetes_cluster.aks.name
  description = "Nombre del clúster de Kubernetes desplegado"
}

output "apim_gateway_url" {
  value       = azurerm_api_management.apim.gateway_url
  description = "Endpoint de la pasarela de API Management"
}

output "swa_default_hostname" {
  value       = azurerm_static_web_app.swa.default_host_name
  description = "URL predeterminada de la Static Web App"
}