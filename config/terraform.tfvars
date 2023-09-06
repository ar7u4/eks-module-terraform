cluster_name                       = "my-eks-cluster"
region                             = "eu-west-3"  # Change to your desired AWS region
vpc_cidr                            = "10.0.0.0/16"
public_subnet_cidrs                 = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
# private_subnet_cidrs                = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"] 
eks_node_group_desired_capacity     = 1
eks_node_group_min_size             = 1
eks_node_group_max_size             = 2
