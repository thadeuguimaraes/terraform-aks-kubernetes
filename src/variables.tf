variable "resource_group_name" {
  default = "thadeuiguimaraes"
}

variable "location" {
  default = "Brazil South"
}

variable "cluster_name" {
  default = "k8s_matrix"
}

variable "default_node_pool_count" {
  default = 3
}

variable "default_node_pool_size" {
  default = "Standard_D2_v2"
}
