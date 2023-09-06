output "eks_cluster_config" {
  value = aws_eks_cluster.example
}

output "eks_node_group_config" {
  value = aws_eks_node_group.example
}

output "vpc_id" {
  description = "ID of the VPC"
  value       = aws_vpc.eks_vpc.id
}
