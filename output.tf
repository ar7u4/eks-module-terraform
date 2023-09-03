output "vpc_id" {
  description = "ID of the VPC"
  value       = module.vpc.vpc_id
}

output "eks_cluster_id" {
  description = "ID of the EKS cluster"
  value       = module.eks_cluster.cluster_id
}

output "eks_node_group_id" {
  description = "ID of the EKS node group"
  value       = module.eks_node_group.node_group_id
}
