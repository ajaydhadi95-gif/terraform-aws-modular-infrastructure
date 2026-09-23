<div align="center">

<img src="https://capsule-render.vercel.app/api?type=waving&color=0:7B42BC,100:FF9900&height=220&section=header&text=Terraform%20AWS%20Infrastructure&fontSize=42&fontColor=ffffff&animation=fadeIn&fontAlignY=38&desc=Infrastructure%20as%20Code%20%7C%20AWS%20%7C%20Terraform&descAlignY=58&descSize=18" width="100%"/>

<p>
A beginner-friendly <strong>Infrastructure as Code (IaC)</strong> project that provisions a full AWS network + EC2 stack — VPC, subnet, Internet Gateway, route table, security group, and EC2 — entirely through Terraform modules.
</p>

<p>
  <img src="https://readme-typing-svg.demolab.com?font=Fira+Code&size=18&pause=1000&color=7B42BC&center=true&vCenter=true&width=600&lines=terraform+init;terraform+plan;terraform+apply;Infrastructure+deployed+%E2%9C%85" alt="Typing SVG" />
</p>

<p>
  <img src="https://img.shields.io/badge/Terraform-7B42BC?style=for-the-badge&logo=terraform&logoColor=white" />
  <img src="https://img.shields.io/badge/AWS-232F3E?style=for-the-badge&logo=amazonaws&logoColor=white" />
  <img src="https://img.shields.io/badge/Ubuntu-E95420?style=for-the-badge&logo=ubuntu&logoColor=white" />
  <img src="https://img.shields.io/badge/License-MIT-yellow?style=for-the-badge" />
</p>


<p align="center">
  <img src="assets/demo.gif" alt="Terraform apply demo" width="800">
</p>


<div align="center">

[![Overview](https://img.shields.io/badge/📌-Overview-blue?style=flat-square)](#-project-overview)
[![Architecture](https://img.shields.io/badge/🏗️-Architecture-blue?style=flat-square)](#️-architecture)
[![Deployment](https://img.shields.io/badge/🚀-Deployment-blue?style=flat-square)](#-deployment-steps)
[![Troubleshooting](https://img.shields.io/badge/🐛-Troubleshooting-blue?style=flat-square)](#-troubleshooting)
[![Author](https://img.shields.io/badge/👨‍💻-Author-blue?style=flat-square)](#-author)

</div>

---

## 📖 Table of Contents

- [Features](#-features)
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
- [Contributing](#-contributing)
- [License](#-license)
- [Author](#-author)
- [Adding the Demo GIF](#-adding-the-demo-gif)

---

## ✨ Features

<table>
<tr>
<td width="33%" valign="top">

### 🧩 Modular
Clean, reusable Terraform modules for VPC, security groups, and EC2 — swap or extend any layer independently.

</td>
<td width="33%" valign="top">

### 🔁 Repeatable
Fully declarative — spin the entire stack up or tear it down with a single command, every time, identically.

</td>
<td width="33%" valign="top">

### 🔐 Secure by design
Least-privilege security group defaults, with clear guidance for locking SSH down to your own IP in production.

</td>
</tr>
</table>

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

<div align="center">

| Technology | Purpose |
| ---------------- | ------------------------- |
| ![Terraform](https://img.shields.io/badge/-Terraform-7B42BC?style=flat-square&logo=terraform&logoColor=white) | Infrastructure as Code |
| ![AWS](https://img.shields.io/badge/-AWS%20VPC-232F3E?style=flat-square&logo=amazonaws&logoColor=white) | Network creation |
| ![AWS](https://img.shields.io/badge/-AWS%20Subnet-232F3E?style=flat-square&logo=amazonaws&logoColor=white) | Host EC2 resources |
| ![AWS](https://img.shields.io/badge/-Internet%20Gateway-232F3E?style=flat-square&logo=amazonaws&logoColor=white) | Internet connectivity |
| ![AWS](https://img.shields.io/badge/-Route%20Table-232F3E?style=flat-square&logo=amazonaws&logoColor=white) | Network routing |
| ![AWS](https://img.shields.io/badge/-Security%20Group-232F3E?style=flat-square&logo=amazonaws&logoColor=white) | Network security |
| ![EC2](https://img.shields.io/badge/-AWS%20EC2-FF9900?style=flat-square&logo=amazonec2&logoColor=white) | Compute/server |
| ![AWS CLI](https://img.shields.io/badge/-AWS%20CLI-232F3E?style=flat-square&logo=amazonaws&logoColor=white) | AWS resource verification |
| ![Git](https://img.shields.io/badge/-Git%2FGitHub-181717?style=flat-square&logo=github&logoColor=white) | Version control |

</div>

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
<tr><th align="left">Region</th><td><code>ap-south-1</code></td></tr>
<tr><th align="left">VPC CIDR</th><td><code>10.0.0.0/16</code> (<code>terraform-vpc</code>)</td></tr>
<tr><th align="left">Subnet CIDR</th><td><code>10.0.1.0/24</code> (<code>ap-south-1a</code>)</td></tr>
<tr><th align="left">Instance Type</th><td><code>t3.medium</code></td></tr>
<tr><th align="left">Key Pair</th><td><code>Dhadi</code></td></tr>
<tr><th align="left">AMI</th><td><code>ami-01a00762f46d584a1</code></td></tr>
<tr><th align="left">Security Group</th><td><code>terraform-ec2-sg</code> — Inbound TCP 22 (SSH)</td></tr>
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
<br>

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
<br>

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
<br>

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

## 🤝 Contributing

Contributions, issues, and feature requests are welcome!

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

---

## 📄 License

This project is licensed under the **MIT License** — feel free to use it for learning or as a starting point for your own infrastructure.

```text
MIT License © Ajay Dhadi
```

---

## 👨‍💻 Author

<div align="center">

**Ajay Dhadi**
*Aspiring AWS / DevOps Engineer*

<img src="https://img.shields.io/badge/AWS-232F3E?style=flat-square&logo=amazonaws&logoColor=white" />
<img src="https://img.shields.io/badge/Terraform-7B42BC?style=flat-square&logo=terraform&logoColor=white" />
<img src="https://img.shields.io/badge/Linux-FCC624?style=flat-square&logo=linux&logoColor=black" />
<img src="https://img.shields.io/badge/Git-F05032?style=flat-square&logo=git&logoColor=white" />
<img src="https://img.shields.io/badge/Docker-2496ED?style=flat-square&logo=docker&logoColor=white" />
<img src="https://img.shields.io/badge/Kubernetes-326CE5?style=flat-square&logo=kubernetes&logoColor=white" />
<img src="https://img.shields.io/badge/Jenkins-D24939?style=flat-square&logo=jenkins&logoColor=white" />
<img src="https://img.shields.io/badge/Ansible-EE0000?style=flat-square&logo=ansible&logoColor=white" />
<img src="https://img.shields.io/badge/Python-3776AB?style=flat-square&logo=python&logoColor=white" />

<br><br>

<a href="https://github.com/<your-username>"><img src="https://img.shields.io/badge/GitHub-181717?style=for-the-badge&logo=github&logoColor=white" /></a>
<a href="https://www.linkedin.com/in/<your-linkedin>"><img src="https://img.shields.io/badge/LinkedIn-0A66C2?style=for-the-badge&logo=linkedin&logoColor=white" /></a>

</div>

---

## ⭐ Project Purpose

This project was created as a hands-on AWS and Terraform learning project to understand how cloud infrastructure can be designed, provisioned, connected, and managed using **Infrastructure as Code**.

If you find this project useful, feel free to ⭐ the repository.

<div align="center">
<img src="https://capsule-render.vercel.app/api?type=waving&color=0:FF9900,100:7B42BC&height=100&section=footer" width="100%"/>
</div>
