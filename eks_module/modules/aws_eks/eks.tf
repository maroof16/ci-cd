resource "aws_eks_cluster" "EKS" {
  name = var.eks_cluster_name

  role_arn = aws_iam_role.EKS_CLUSTER.arn
  version = "1.24"
  vpc_config {
    endpoint_private_access = false
    endpoint_public_access = true
    subnet_ids = var.subnet_ids
  }
    depends_on = [
    aws_iam_role_policy_attachment.amazon_eks_cluster_policy
    ]
    tags = var.tags
}
resource "aws_iam_role" "EKS_CLUSTER" {
  tags = local.tags
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
 
resource "aws_iam_role_policy_attachment" "amazon_eks_cluster_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role = aws_iam_role.EKS_CLUSTER.name


}

resource "aws_iam_role_policy_attachment" "AmazonEC2containerRegistryReadonly-EKS" {
   policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
   role = aws_iam_role.EKS_CLUSTER.name

}
