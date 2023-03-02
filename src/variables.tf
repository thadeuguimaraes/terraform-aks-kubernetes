variable "resource_group_name" {
  default = "rg_k8s_matrix"
}

variable "location" {
  default = "Brazil South"
}

variable "cluster_name" {
  default = "k8s_matrix"
}

variable "default_node_pool_count" {
  default = 2
}

variable "default_node_pool_size" {
  default = "Standard_D2_v2"
}