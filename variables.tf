variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
}

variable "region" {
  description = "AWS region"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "public_subnet_cidrs" {
  description = "List of CIDR blocks for public subnets"
  type        = list(string)
}

variable "eks_node_group_desired_capacity" {
  description = "Desired capacity for the EKS node group"
  type        = number
}

variable "eks_node_group_min_size" {
  description = "Minimum size for the EKS node group"
  type        = number
}

variable "eks_node_group_max_size" {
  description = "Maximum size for the EKS node group"
  type        = number
}
