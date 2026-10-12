variable "resource_group_name" {
  type        = string
  description = "Grupo de recursos pre-provisionado del sandbox"
  default     = "1-75e47af0-playground-sandbox"
}

variable "location" {
  type        = string
  description = "Región permitida por las reglas del sandbox"
  default     = "southcentralus"
}

variable "environment" {
  type        = string
  description = "Entorno de despliegue"
  default     = "dev"
}