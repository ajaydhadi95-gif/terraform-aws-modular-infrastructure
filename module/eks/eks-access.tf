
# Jenkins EC2 IAM role ko EKS access entry dena
resource "aws_eks_access_entry" "jenkins" {
  cluster_name  = aws_eks_cluster.this.name
  principal_arn = "arn:aws:iam::174376948569:role/terraform-ssm-role"
  type          = "STANDARD"

  depends_on = [
    aws_eks_cluster.this
  ]
}

# Jenkins role ko lab cluster par administrator access
resource "aws_eks_access_policy_association" "jenkins_admin" {
  cluster_name  = aws_eks_cluster.this.name
  principal_arn = aws_eks_access_entry.jenkins.principal_arn
  policy_arn    = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"

  access_scope {
    type = "cluster"
  }

  depends_on = [
    aws_eks_access_entry.jenkins
  ]
}
