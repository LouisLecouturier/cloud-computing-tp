variable "postgres_account_name" {
  type        = string
  default     = null
  description = "Account used for the db."
}

variable "azurerm_resource_group_name" {
  type        = string
  default     = null
  description = "Name of the ressource group."
}

variable "location" {
  type        = string
  description = "The location/region where the resource group is created."
}


variable "administrator_login" {
  type        = string
  default     = "louislecouturier"
  description = "The administrator login for the PostgreSQL Server."
}

variable "administrator_login_password" {
  type        = string
  default     = "Azerty1234"
  description = "The administrator login password for the PostgreSQL Server."

}
