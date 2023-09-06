# Amazon EKS Cluster Documentation

## Overview

This README provides an overview of the infrastructure created for our Amazon Elastic Kubernetes Service (Amazon EKS) cluster. The infrastructure is managed using Terraform and includes the following resources:

1. Amazon VPC (Virtual Private Cloud)
2. Subnets (Public and Private)
3. Security Groups
4. Amazon EKS Cluster
5. Node Groups for EKS

## Infrastructure Details

### Amazon VPC (`eks_vpc`)

- **Purpose**: The Amazon VPC serves as the network isolation for our EKS cluster.
- **CIDR Block**: [Specify the CIDR block used for the VPC]
- **Components**: 
  - Public and private subnets
  - Route tables
  - Internet Gateway (for public subnets)
  - NAT Gateway (for private subnets)
  - DHCP options set

### Subnets

#### Public Subnets (`public_subnet`)

- **Purpose**: Public subnets are used for resources that need direct internet access.
- **Availability Zones**: [List the availability zones where public subnets are created]
- **CIDR Blocks**: [List the CIDR blocks for each public subnet]

#### Private Subnets (`private_subnet`)

- **Purpose**: Private subnets are used for resources that do not require direct internet access.
- **Availability Zones**: [List the availability zones where private subnets are created]
- **CIDR Blocks**: [List the CIDR blocks for each private subnet]

### Security Groups (`eks_node_sg`)

- **Purpose**: Security groups are used to control inbound and outbound traffic for Amazon EC2 instances in the EKS cluster.
- **Rules**: [List the security group rules defined for EKS nodes]

### Amazon EKS Cluster (`example`)

- **Purpose**: The Amazon EKS cluster provides a managed Kubernetes control plane.
- **Name**: [Specify the name of the EKS cluster]
- **Worker Node Groups**: [Specify the names of worker node groups attached to the cluster]

### Node Groups for EKS (`example-node-group`)

- **Purpose**: Node groups are Auto Scaling Groups (ASGs) that provide compute capacity for the EKS cluster.
- **Name**: [Specify the name of the node group]
- **Instance Type**: [Specify the EC2 instance type for nodes]
- **Scaling Configuration**: [Specify scaling policies, min, max, and desired capacity]
- **Subnets**: [List the subnets used by the node group]

## Dependencies

- IAM Roles: Ensure that the necessary IAM roles and policies are in place for the EKS cluster and nodes.
- Worker Node AMI: Make sure a suitable Amazon Machine Image (AMI) is available for the worker nodes.

## Terraform Configuration

- **Terraform Version**: [Specify the version of Terraform used]
- **Terraform Files**:
  - `main.tf`: The main Terraform configuration file.
  - `variables.tf`: Variable definitions.
  - `outputs.tf`: Output definitions.
  - `terraform.tfvars`: Variable values.

## Maintenance and Operations

- **Cluster Management**: To manage the EKS cluster, use the AWS Management Console, AWS CLI, or other Kubernetes management tools.
- **Scaling**: Use the Auto Scaling Group (ASG) settings to scale worker nodes as needed.
- **Security**: Regularly review and update security group rules and IAM policies for the
