provider "aws" {
  region = var.region
}

# Create VPC
module "vpc" {
  source      = "terraform-aws-modules/vpc/aws"
  name        = "eks-vpc"
  cidr        = var.vpc_cidr
  azs         = ["${var.region}a", "${var.region}b", "${var.region}c"]
  private_subnets = var.private_subnet_cidrs
  public_subnets  = var.public_subnet_cidrs
}

# Create EKS Cluster
module "eks_cluster" {
  source          = "terraform-aws-modules/eks/aws"
  cluster_name    = var.cluster_name
  cluster_version = "1.21"
  subnets         = module.vpc.private_subnets
  vpc_id          = module.vpc.vpc_id
  tags            = { "Environment" = "Dev" }
}

# Create EKS Node Group
module "eks_node_group" {
  source          = "terraform-aws-modules/eks/aws//modules/node_group"
  cluster_name    = module.eks_cluster.cluster_id
  node_group_name = "example-node-group"
  node_role_name  = "eks_node_role"
  node_instance_type   = var.eks_node_group_instance_type
  desired_capacity     = var.eks_node_group_desired_capacity
  min_size             = var.eks_node_group_min_size
  max_size             = var.eks_node_group_max_size
  subnet_ids           = module.vpc.private_subnets
  tags = {
    "Environment" = "Dev"
    "Name"        = "example-node-group"
  }
}

# Output the EKS Cluster Configuration
output "eks_cluster_config" {
  value = module.eks_cluster
}

# Output the EKS Node Group Configuration
output "eks_node_group_config" {
  value = module.eks_node_group
}
