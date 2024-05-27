

resource "aws_eks_addon" "ebs_csi_driver" {
  cluster_name               = var.cluster_name
  addon_name                 = "aws-ebs-csi-driver"
  

}
