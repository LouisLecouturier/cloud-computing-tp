
variable "azurerm_resource_group_name" {
  type        = string
  default     = null
  description = "Name of the ressource group."
}

variable "location" {
  type        = string
  description = "The location/region where the resource group is created."
}
