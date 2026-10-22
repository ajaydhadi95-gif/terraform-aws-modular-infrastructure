# =========================================================
# EKS CLUSTER SECURITY GROUP
# =========================================================

resource "aws_security_group" "eks_cluster" {
  name        = var.eks_cluster_security_group_name
  description = var.eks_cluster_security_group_description
  vpc_id      = var.vpc_id

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name      = var.eks_cluster_security_group_name
    ManagedBy = "Terraform"
  }
}


# =========================================================
# EKS NODE SECURITY GROUP
# =========================================================

resource "aws_security_group" "eks_node" {
  name        = var.eks_node_security_group_name
  description = var.eks_node_security_group_description
  vpc_id      = var.vpc_id

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name      = var.eks_node_security_group_name
    ManagedBy = "Terraform"
  }
}


# =========================================================
# EKS NODE -> NODE
# =========================================================

resource "aws_vpc_security_group_ingress_rule" "eks_node_to_node" {
  security_group_id            = aws_security_group.eks_node.id
  referenced_security_group_id = aws_security_group.eks_node.id

  ip_protocol = "-1"

  description = "Allow EKS node to node communication"
}


# =========================================================
# EKS CLUSTER -> NODE HTTPS
# =========================================================

resource "aws_vpc_security_group_ingress_rule" "eks_cluster_to_node" {
  security_group_id            = aws_security_group.eks_node.id
  referenced_security_group_id = aws_security_group.eks_cluster.id

  ip_protocol = "tcp"
  from_port   = 443
  to_port     = 443

  description = "Allow EKS cluster to node HTTPS"
}


# =========================================================
# EKS CLUSTER -> NODE KUBELET
# =========================================================
# Required for kubectl logs, exec and port-forward
# Control plane communicates with kubelet on TCP 10250

resource "aws_vpc_security_group_ingress_rule" "eks_cluster_to_node_kubelet" {
  security_group_id            = aws_security_group.eks_node.id
  referenced_security_group_id = aws_security_group.eks_cluster.id

  ip_protocol = "tcp"
  from_port   = 10250
  to_port     = 10250

  description = "Allow EKS control plane to worker kubelet"
}


# =========================================================
# NODE -> EKS CLUSTER HTTPS
# =========================================================

resource "aws_vpc_security_group_ingress_rule" "eks_node_to_cluster" {
  security_group_id            = aws_security_group.eks_cluster.id
  referenced_security_group_id = aws_security_group.eks_node.id

  ip_protocol = "tcp"
  from_port   = 443
  to_port     = 443

  description = "Allow EKS node to cluster HTTPS"
}


# =========================================================
# HTTP TO EKS NODES
# =========================================================

resource "aws_vpc_security_group_ingress_rule" "eks_node_http" {
  security_group_id = aws_security_group.eks_node.id

  cidr_ipv4 = "0.0.0.0/0"

  ip_protocol = "tcp"
  from_port   = var.http_port
  to_port     = var.http_port

  description = "Allow HTTP application traffic"
}


# =========================================================
# HTTPS TO EKS NODES
# =========================================================

resource "aws_vpc_security_group_ingress_rule" "eks_node_https" {
  security_group_id = aws_security_group.eks_node.id

  cidr_ipv4 = "0.0.0.0/0"

  ip_protocol = "tcp"
  from_port   = var.https_port
  to_port     = var.https_port

  description = "Allow HTTPS application traffic"
}


# =========================================================
# BACKEND APPLICATION PORT
# =========================================================

resource "aws_vpc_security_group_ingress_rule" "eks_node_backend" {
  security_group_id = aws_security_group.eks_node.id

  cidr_ipv4 = "10.0.0.0/16"

  ip_protocol = "tcp"
  from_port   = var.backend_port
  to_port     = var.backend_port

  description = "Allow backend application traffic inside VPC"
}


# =========================================================
# RDS SECURITY GROUP
# =========================================================

resource "aws_security_group" "rds" {
  name        = var.rds_security_group_name
  description = var.rds_security_group_description
  vpc_id      = var.vpc_id

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name      = var.rds_security_group_name
    ManagedBy = "Terraform"
  }
}


# =========================================================
# EKS NODES -> RDS MYSQL
# =========================================================

resource "aws_vpc_security_group_ingress_rule" "rds_mysql_from_eks" {
  security_group_id            = aws_security_group.rds.id
  referenced_security_group_id = aws_security_group.eks_node.id

  ip_protocol = "tcp"
  from_port   = var.sql_port
  to_port     = var.sql_port

  description = "Allow MySQL from EKS nodes"
}


# =========================================================
# JENKINS SECURITY GROUP
# =========================================================

resource "aws_security_group" "jenkins" {
  name        = var.jenkins_security_group_name
  description = var.jenkins_security_group_description
  vpc_id      = var.vpc_id

  egress {
    description = "Allow outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name      = var.jenkins_security_group_name
    ManagedBy = "Terraform"
    Purpose   = "Jenkins CI/CD"
  }
}

resource "aws_vpc_security_group_ingress_rule" "jenkins_ssh" {
  security_group_id = aws_security_group.jenkins.id
  cidr_ipv4         = var.jenkins_allowed_cidr
  ip_protocol       = "tcp"
  from_port         = var.ssh_port
  to_port           = var.ssh_port
  description       = "Allow SSH access to Jenkins"
}

resource "aws_vpc_security_group_ingress_rule" "jenkins_web" {
  security_group_id = aws_security_group.jenkins.id
  cidr_ipv4         = var.jenkins_allowed_cidr
  ip_protocol       = "tcp"
  from_port         = var.jenkins_port
  to_port           = var.jenkins_port
  description       = "Allow Jenkins web UI"
}


# =========================================================
# JENKINS EC2 -> RDS MYSQL
# =========================================================

resource "aws_vpc_security_group_ingress_rule" "rds_mysql_from_jenkins" {
  security_group_id            = aws_security_group.rds.id
  referenced_security_group_id = aws_security_group.jenkins.id

  ip_protocol = "tcp"
  from_port   = var.sql_port
  to_port     = var.sql_port

  description = "Allow MySQL from Jenkins EC2"
}
