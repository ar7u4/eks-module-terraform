# Configure the AWS provider
provider "aws" {
  region = var.region
}

# Create a VPC
resource "aws_vpc" "eks_vpc" {
  cidr_block = var.vpc_cidr
}

# Create subnets (public and private)
resource "aws_subnet" "public_subnet" {
  count                   = length(var.public_subnet_cidrs)
  vpc_id                  = aws_vpc.eks_vpc.id
  cidr_block              = var.public_subnet_cidrs[count.index]
  availability_zone       = element(["a", "b", "c"], count.index)
  map_public_ip_on_launch = true
}

resource "aws_subnet" "private_subnet" {
  count                   = length(var.private_subnet_cidrs)
  vpc_id                  = aws_vpc.eks_vpc.id
  cidr_block              = var.private_subnet_cidrs[count.index]
  availability_zone       = element(["a", "b", "c"], count.index)
  map_public_ip_on_launch = false
}

# Create a security group for EKS nodes
resource "aws_security_group" "eks_node_sg" {
  name        = "eks-node-sg"
  description = "Security group for EKS nodes"
  vpc_id      = aws_vpc.eks_vpc.id

  # Add your security group rules here as needed
}

# Create the EKS cluster
resource "aws_eks_cluster" "example" {
  name     = var.cluster_name
  role_arn = aws_iam_role.eks_cluster_role.arn

  vpc_config {
    subnet_ids = aws_subnet.private_subnet[*].id
  }
}

# Create an IAM role for the EKS cluster
resource "aws_iam_role" "eks_cluster_role" {
  name = "eks-cluster-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "eks.amazonaws.com"
        }
      }
    ]
  })
}

# Attach necessary policies to the IAM role for EKS cluster (e.g., AmazonEKSClusterPolicy)
resource "aws_iam_policy_attachment" "eks_cluster_policy_attachment" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  roles      = [aws_iam_role.eks_cluster_role.name]
}

# Create a node group for the EKS cluster
resource "aws_eks_node_group" "example" {
  cluster_name    = aws_eks_cluster.example.name
  node_group_name = "example-node-group"
  node_role_arn   = aws_iam_role.eks_node_role.arn

  scaling_config {
    desired_size = var.eks_node_group_desired_capacity
    max_size     = var.eks_node_group_max_size
    min_size     = var.eks_node_group_min_size
  }

  subnet_ids = aws_subnet.private_subnet[*].id
}

# Create an IAM role for EKS nodes
resource "aws_iam_role" "eks_node_role" {
  name = "eks-node-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}

# Output the EKS Cluster Configuration
output "eks_cluster_config" {
  value = aws_eks_cluster.example
}

# Output the EKS Node Group Configuration
output "eks_node_group_config" {
  value = aws_eks_node_group.example
}

# Output the VPC ID
output "vpc_id" {
  description = "ID of the VPC"
  value       = aws_vpc.eks_vpc.id
}
