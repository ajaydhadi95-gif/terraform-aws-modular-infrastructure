<div align="center">

# 🚀 Terraform AWS Infrastructure

### Beginner-friendly Infrastructure as Code (IaC) project that provisions a complete AWS network + EC2 stack using Terraform

![Terraform](https://readme-typing-svg.demolab.com?font=Fira+Code&size=18&pause=1000&color=7B42BC&center=true&vCenter=true&width=600&lines=terraform+init;terraform+plan;terraform+apply;Infrastructure+deployed+%E2%9C%85)

[![Terraform](https://img.shields.io/badge/Terraform-7B42BC?style=for-the-badge&logo=terraform&logoColor=white)](https://www.terraform.io/)
[![AWS](https://img.shields.io/badge/AWS-232F3E?style=for-the-badge&logo=amazonaws&logoColor=white)](https://aws.amazon.com/)
[![Ubuntu](https://img.shields.io/badge/Ubuntu-E95420?style=for-the-badge&logo=ubuntu&logoColor=white)](https://ubuntu.com/)
[![License](https://img.shields.io/badge/License-MIT-yellow?style=for-the-badge)](#-license)

</div>

<p align="center">
  <img src="assets/demo.gif" alt="Terraform apply demo" width="750">
</p>

> 💡 **Note:** Replace `assets/demo.gif` with a real screen recording of your `terraform apply` run (see [Adding the demo GIF](#-adding-the-demo-gif) below).

---

## 📖 Table of Contents

- [Project Overview](#-project-overview)
- [Architecture](#️-architecture)
- [Technologies Used](#️-technologies-used)
- [Project Structure](#-project-structure)
- [Infrastructure Flow](#-infrastructure-flow)
- [AWS Configuration](#️-aws-configuration)
- [Prerequisites](#️-prerequisites)
- [Deployment Steps](#-deployment-steps)
- [Verify Infrastructure](#-verify-infrastructure)
- [Connect to EC2](#️-connect-to-ec2)
- [Network Flow for SSH](#-network-flow-for-ssh)
- [Useful Commands](#-useful-terraform-commands)
- [Troubleshooting](#-troubleshooting)
- [Terraform Outputs](#-terraform-outputs)
- [Security Best Practices](#-security-best-practices)
- [What I Learned](#-what-i-learned-from-this-project)
- [Skills Demonstrated](#-devops-skills-demonstrated)
- [Author](#-author)
- [Adding the Demo GIF](#-adding-the-demo-gif)

---

## 📌 Project Overview

The goal of this project is to automate AWS infrastructure provisioning instead of creating resources manually from the AWS Management Console.

### ✅ Resources Created

| Resource | Description |
|---|---|
| 🌐 AWS VPC | Isolated virtual network |
| 🧱 Public Subnet | Hosts the EC2 instance |
| 🚪 Internet Gateway | Provides internet access |
| 🗺️ Public Route Table | Routes traffic to the internet |
| 🔗 Route Table Association | Links subnet to route table |
| 🛡️ Security Group | Controls inbound/outbound traffic |
| 💻 EC2 Instance | Compute resource |
| 📤 Terraform Outputs | Exposes key resource info |

---

## 🏗️ Architecture

```text
                         AWS Cloud
                             │
                             ▼
                    ┌─────────────────┐
                    │       VPC       │
                    │  10.0.0.0/16    │
                    └────────┬────────┘
                             │
                    ┌────────▼────────┐
                    │  Public Subnet  │
                    │  10.0.1.0/24    │
                    │  ap-south-1a    │
                    └────────┬────────┘
                             │
              ┌──────────────┴──────────────┐
              │                             │
              ▼                             ▼
      ┌───────────────┐             ┌───────────────┐
      │ Route Table   │             │ Security Group│
      │ 0.0.0.0/0     │             │    TCP 22     │
      │      ↓        │             │     SSH       │
      │ Internet GW   │             └───────┬───────┘
      └───────┬───────┘                     │
              │                             │
              └──────────────┬──────────────┘
                             ▼
                    ┌─────────────────┐
                    │   EC2 Instance  │
                    │    t3.medium    │
                    │     Ubuntu      │
                    └────────┬────────┘
                             │
                             ▼
                         Public IP
                             │
                             ▼
                         SSH : 22
```

---

## 🛠️ Technologies Used

| Technology | Purpose |
| ---------------- | ------------------------- |
| Terraform | Infrastructure as Code |
| AWS VPC | Network creation |
| AWS Subnet | Host EC2 resources |
| Internet Gateway | Internet connectivity |
| Route Table | Network routing |
| Security Group | Network security |
| AWS EC2 | Compute/server |
| AWS CLI | AWS resource verification |
| Git/GitHub | Version control |

---

## 📁 Project Structure

```text
terraform/
│
├── main.tf
├── provider.tf
├── variables.tf
├── outputs.tf
│
└── module/
    │
    ├── vpc/
    │   ├── main.tf
    │   ├── variables.tf
    │   └── outputs.tf
    │
    ├── security_group/
    │   ├── main.tf
    │   ├── variables.tf
    │   └── outputs.tf
    │
    └── ec2/
        ├── main.tf
        ├── variables.tf
        └── outputs.tf
```

---

## 🔄 Infrastructure Flow

```text
Terraform
    │
    ▼
provider.tf
    │
    ▼
main.tf
    │
    ├──────────────► VPC Module
    │                    │
    │                    ├── VPC
    │                    ├── Subnet
    │                    ├── Internet Gateway
    │                    ├── Route Table
    │                    └── Route Association
    │
    ├──────────────► Security Group Module
    │                    │
    │                    └── SSH Port 22
    │
    └──────────────► EC2 Module
                         │
                         └── EC2 Instance
```

---

## ☁️ AWS Configuration

<table>
<tr><th>Region</th><td><code>ap-south-1</code></td></tr>
<tr><th>VPC CIDR</th><td><code>10.0.0.0/16</code> (<code>terraform-vpc</code>)</td></tr>
<tr><th>Subnet CIDR</th><td><code>10.0.1.0/24</code> (<code>ap-south-1a</code>)</td></tr>
<tr><th>Instance Type</th><td><code>t3.medium</code></td></tr>
<tr><th>Key Pair</th><td><code>Dhadi</code></td></tr>
<tr><th>AMI</th><td><code>ami-01a00762f46d584a1</code></td></tr>
<tr><th>Security Group</th><td><code>terraform-ec2-sg</code> — Inbound TCP 22 (SSH)</td></tr>
</table>

> ⚠️ For production environments, restrict SSH access to your trusted IP address instead of `0.0.0.0/0`.

---

## ⚙️ Prerequisites

Before running this project, install/configure:

**1. AWS CLI**
```bash
aws --version
```

**2. Terraform**
```bash
terraform version
```

**3. AWS Credentials**
```bash
aws configure
aws sts get-caller-identity
```

---

## 🚀 Deployment Steps

| Step | Command | Description |
|---|---|---|
| 1️⃣ Clone repo | `git clone <YOUR_GITHUB_REPOSITORY_URL>` | Get the project locally |
| 2️⃣ Move in | `cd terraform` | Enter the project directory |
| 3️⃣ Initialize | `terraform init` | Download providers & init working dir |
| 4️⃣ Format | `terraform fmt` | Standardize file formatting |
| 5️⃣ Validate | `terraform validate` | Check configuration validity |
| 6️⃣ Plan | `terraform plan` | Preview resources to be created |
| 7️⃣ Apply | `terraform apply` | Provision the AWS resources (type `yes`) |

---

## 🔍 Verify Infrastructure

```bash
terraform state list
```

Expected output:

```text
module.vpc.aws_vpc.this
module.vpc.aws_subnet.public
module.vpc.aws_internet_gateway.this
module.vpc.aws_route_table.public
module.vpc.aws_route_table_association.public
module.security_group.aws_security_group.ec2_sg
module.ec2.aws_instance.my_instance
```

---

## 🖥️ Connect to EC2

Get the public IP:
```bash
terraform output public_ip
```

Connect via SSH:
```bash
ssh -i Dhadi.pem ubuntu@<PUBLIC_IP>
```

Example:
```bash
ssh -i Dhadi.pem ubuntu@65.0.76.50
```

---

## 🔐 Network Flow for SSH

```text
Your Computer
      │
      │ SSH : 22
      ▼
   Internet
      │
      ▼
Internet Gateway
      │
      ▼
Public Route Table
0.0.0.0/0 → IGW
      │
      ▼
Public Subnet
      │
      ▼
Security Group
TCP 22 Allowed
      │
      ▼
EC2 Instance
      │
      ▼
Ubuntu Server
```

---

## 🧪 Useful Terraform Commands

| Command | Purpose |
|---|---|
| `terraform init` | Initialize |
| `terraform fmt` | Format |
| `terraform validate` | Validate |
| `terraform plan` | Plan |
| `terraform apply` | Apply |
| `terraform output` | Show outputs |
| `terraform state list` | Check state |
| `terraform state show <resource>` | Show specific resource |
| `terraform destroy` | Destroy infrastructure ⚠️ |

---

## 🐛 Troubleshooting

<details>
<summary><strong>Issue 1: Security group and subnet belong to different networks</strong></summary>

**Cause:** The Security Group and Subnet belong to different VPCs.

**Solution:** Pass the VPC ID from the VPC module:

```hcl
module "security_group" {
  source = "./module/security_group"
  vpc_id = module.vpc.vpc_id
}
```

And inside the Security Group module:

```hcl
resource "aws_security_group" "ec2_sg" {
  vpc_id = var.vpc_id
}
```
</details>

<details>
<summary><strong>Issue 2: SSH connection timeout</strong></summary>

```text
ssh: connect to host <PUBLIC_IP> port 22: Connection timed out
```

Check:
1. EC2 is running
2. EC2 has a public IP
3. Security Group allows TCP port 22
4. Subnet has a route to an Internet Gateway
5. Route table is associated with the subnet

Required route:
```text
0.0.0.0/0 → Internet Gateway
```
</details>

<details>
<summary><strong>Issue 3: Security group duplicate</strong></summary>

```text
InvalidGroup.Duplicate
```

**Cause:** A Security Group with the same name already exists in the target VPC.

Check using AWS CLI:
```bash
aws ec2 describe-security-groups --region ap-south-1
```

If an unmanaged old resource is blocking Terraform, investigate its dependencies before deleting it.
</details>

---

## 📤 Terraform Outputs

```bash
terraform output
```

| Output | Description |
|---|---|
| `vpc_id` | ID of the created VPC |
| `vpc_cidr` | CIDR block of the VPC |
| `subnet_id` | ID of the public subnet |
| `security_group_id` | ID of the security group |
| `instance_id` | ID of the EC2 instance |
| `public_ip` | Public IP of the EC2 instance |

---

## 🔒 Security Best Practices

For learning purposes, SSH may be opened using `0.0.0.0/0`. For production, restrict to your own public IP, e.g. `203.0.113.10/32`.

- 🚫 Never commit AWS access keys to GitHub
- 🚫 Never commit `.pem` private keys
- 📁 Add Terraform state files to `.gitignore`
- 👤 Use IAM roles where possible
- 🔐 Use least-privilege IAM permissions
- 🛡️ Restrict Security Group inbound rules

**Recommended `.gitignore`:**

```gitignore
# Terraform
.terraform/
*.tfstate
*.tfstate.*
crash.log
crash.*.log

# Terraform variable files
*.tfvars
*.tfvars.json

# AWS credentials
.aws/
credentials

# SSH private keys
*.pem
*.key

# OS files
.DS_Store
Thumbs.db

# IDE
.vscode/
.idea/
```

> Keep `.terraform.lock.hcl` in Git so provider versions can be reproduced consistently.

---

## 📚 What I Learned From This Project

- Infrastructure as Code
- Terraform modules, variables & outputs
- Terraform state management
- AWS VPC networking & CIDR blocks
- Public subnets, Internet Gateways, Route Tables & associations
- Security Groups
- EC2 provisioning & SSH connectivity
- AWS CLI troubleshooting
- Terraform dependency management

---

## 🎯 DevOps Skills Demonstrated

```text
Terraform
   │
   ├── Infrastructure as Code
   ├── Modules
   ├── Variables
   ├── Outputs
   ├── State Management
   └── Resource Dependencies
          │
          ▼
        AWS
          │
          ├── VPC
          ├── Subnet
          ├── Internet Gateway
          ├── Route Table
          ├── Security Group
          └── EC2
```

---

## 👨‍💻 Author

<div align="center">

**Ajay Dhadi**
*Aspiring AWS / DevOps Engineer*

![AWS](https://img.shields.io/badge/AWS-232F3E?style=flat-square&logo=amazonaws&logoColor=white)
![Terraform](https://img.shields.io/badge/Terraform-7B42BC?style=flat-square&logo=terraform&logoColor=white)
![Linux](https://img.shields.io/badge/Linux-FCC624?style=flat-square&logo=linux&logoColor=black)
![Git](https://img.shields.io/badge/Git-F05032?style=flat-square&logo=git&logoColor=white)
![Docker](https://img.shields.io/badge/Docker-2496ED?style=flat-square&logo=docker&logoColor=white)
![Kubernetes](https://img.shields.io/badge/Kubernetes-326CE5?style=flat-square&logo=kubernetes&logoColor=white)
![Jenkins](https://img.shields.io/badge/Jenkins-D24939?style=flat-square&logo=jenkins&logoColor=white)
![Ansible](https://img.shields.io/badge/Ansible-EE0000?style=flat-square&logo=ansible&logoColor=white)
![Python](https://img.shields.io/badge/Python-3776AB?style=flat-square&logo=python&logoColor=white)

</div>

---

## 🎬 Adding the Demo GIF

This README references `assets/demo.gif` at the top. To add a real one:

1. Record your terminal running through `terraform init → plan → apply` using a tool like [Terminalizer](https://terminalizer.com/), [asciinema](https://asciinema.org/) + [agg](https://github.com/asciinema/agg), or [VHS](https://github.com/charmbracelet/vhs).
2. Export the recording as a `.gif`.
3. Create an `assets/` folder in your repo root and place the file there as `assets/demo.gif`.
4. Commit and push — GitHub will render it automatically at the top of this README.

---

## ⭐ Project Purpose

This project was created as a hands-on AWS and Terraform learning project to understand how cloud infrastructure can be designed, provisioned, connected, and managed using **Infrastructure as Code**.

If you find this project useful, feel free to ⭐ the repository.
