variable "location" {
  default = "Brazil South"
}

variable "k8s_matrix" {
  default = "reload-cluster"
}

variable "default_node_pool_count" {
  default = 3
}

variable "default_node_pool_size" {
  default = "Standard_D2_v2"
}

variable "account_tier" {
  default = "Standard"
}

variable "account_replication_type" {
  default = "LRS"
}
