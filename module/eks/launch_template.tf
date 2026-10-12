# =========================================================
# EKS UBUNTU 24.04 NODE GROUP LAUNCH TEMPLATE
# =========================================================

data "aws_ssm_parameter" "ubuntu_eks_ami" {
  name = "/aws/service/canonical/ubuntu/eks/24.04/1.34/stable/current/amd64/hvm/ebs-gp3/ami-id"
}

resource "aws_launch_template" "eks_nodes" {
  name_prefix = "${var.cluster_name}-ubuntu-nodes-"

  image_id = data.aws_ssm_parameter.ubuntu_eks_ami.value

  instance_type = var.node_instance_type

  vpc_security_group_ids = [
    var.node_security_group_id
  ]

  user_data = base64encode(<<-EOF
    #!/bin/bash
    /etc/eks/bootstrap.sh ${var.cluster_name}
  EOF
  )

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name      = "${var.cluster_name}-ubuntu-node"
      ManagedBy = "Terraform"
      OS        = "Ubuntu 24.04"
    }
  }
}