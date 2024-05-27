# resource "aws_eks_cluster" "marioud_cluster" {
#   name     = var.eks_name
#   role_arn = aws_iam_role.eks_cluster_role.arn

#   vpc_config {
#     subnet_ids = concat(var.pri_subnet_ids, var.pub_subnet_ids)
#   }
# }

# resource "aws_iam_role" "eks_cluster_role" {
#   name = "eks-cluster"

#   assume_role_policy = jsonencode({
#     Version   = "2012-10-17",
#     Statement = [
#       {
#         Effect    = "Allow",
#         Principal = {
#           Service = "eks.amazonaws.com"
#         },
#         Action    = "sts:AssumeRole"
#       }
#     ]
#   })
# }

# # resource "aws_iam_policy" "ecr_policy" {
# #   name        = "ecr_policy"
# #   description = "Allow ECR actions"
# #   policy      = jsonencode({
# #     Version   = "2012-10-17",
# #     Statement = [
# #       {
# #         Effect   = "Allow",
# #         Action   = [
# #           "ecr:GetDownloadUrlForLayer",
# #           "ecr:BatchGetImage",
# #           "ecr:BatchCheckLayerAvailability",
# #           "ecr:GetAuthorizationToken"
# #         ],
# #         Resource = "*"
# #       }
# #     ]
# #   })
# # }

# # resource "aws_iam_role_policy_attachment" "demo-AmazonEKSClusterPolicy" {
# #   policy_arn = aws_iam_policy.ecr_policy.arn
# #   role       = aws_iam_role.eks_cluster_role.id
# # }

# resource "aws_eks_node_group" "private-nodes" {
#   cluster_name = aws_eks_cluster.marioud_cluster.id
#   node_group_name = "private-nodes"
#   node_role_arn = aws_iam_role.nodes.arn
#   subnet_ids = var.pri_subnet_ids
#   capacity_type  = "ON_DEMAND"
#   instance_types = ["t2.medium"]

#   scaling_config {
#     desired_size = var.desired
#     max_size     = var.max_size
#     min_size     = var.min_size
#   }

#   update_config {
#     max_unavailable = 1
#   }

#   labels = {
#     role = "general"
#   }
# }

# resource "aws_iam_role" "nodes" {
#   name = "eks-node-group-nodes"

#   assume_role_policy = jsonencode({
#     Statement = [{
#       Action    = "sts:AssumeRole",
#       Effect    = "Allow",
#       Principal = {
#         Service = "ec2.amazonaws.com"
#       }
#     }],
#     Version   = "2012-10-17"
#   })
# }

# resource "aws_iam_role_policy_attachment" "nodes-AmazonEKSWorkerNodePolicy" {
#   policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
#   role       = aws_iam_role.nodes.id
# }

# resource "aws_iam_role_policy_attachment" "nodes-AmazonEKS_CNI_Policy" {
#   policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
#   role       = aws_iam_role.nodes.id
# }

# resource "aws_iam_role_policy_attachment" "nodes-AmazonEC2ContainerRegistryReadOnly" {
#   policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
#   role       = aws_iam_role.nodes.id
# }

resource "aws_eks_cluster" "marioud_cluster" {
    name = var.eks_name
    role_arn = aws_iam_role.eks_cluster_role.arn
    vpc_config {
       subnet_ids = concat(var.pri_subnet_ids,var.pub_subnet_ids)
      
  }
      
    }
resource "aws_iam_role" "eks_cluster_role" {
  name = "eks-cluster"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "demo-AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.eks_cluster_role.id
}

resource "aws_eks_node_group" "private-nodes" {
  cluster_name = aws_eks_cluster.marioud_cluster.id
  node_group_name = "private-nodes"
  node_role_arn = aws_iam_role.nodes.arn
  subnet_ids = var.pri_subnet_ids
   capacity_type  = "ON_DEMAND"
   instance_types = ["t2.medium"]

   scaling_config {
    desired_size = var.desired
    max_size     = var.max_size
    min_size     = var.min_size
  }

   update_config {
    max_unavailable = 1
  }




  labels = {
    role = "general"
  }

}
resource "aws_iam_role" "nodes" {
  name = "eks-node-group-nodes"

  assume_role_policy = jsonencode({
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
    Version = "2012-10-17"
  })
}

resource "aws_iam_role_policy_attachment" "nodes-AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.nodes.id
}

resource "aws_iam_role_policy_attachment" "nodes-AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.nodes.id
}

resource "aws_iam_role_policy_attachment" "nodes-AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.nodes.id
}
resource "aws_iam_role_policy_attachment" "AmazonEBSCSIDriverPolicy"  {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"
  role = aws_iam_role.nodes.id
  
}