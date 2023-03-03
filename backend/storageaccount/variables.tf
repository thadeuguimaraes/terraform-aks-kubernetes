variable "location" {
  description = "Vaiável que indica onde os recursos vão ser criados"
  type        = string
  default     = "Brazil South"
}

variable "account_tier" {
  description = "Tier da storage Accoutn na Azure"
  type        = string
  default     = "Standard"
}

variable "account_replication_type" {
  description = "Tipo de replicação da Storage Account"
  type        = string
  default     = "LRS"
}
