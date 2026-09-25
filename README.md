<div align="center">

# 🌐 Terraform AWS VPC Infrastructure

### Production-style AWS networking, built the Infrastructure-as-Code way

<img src="https://readme-typing-svg.demolab.com?font=Fira+Code&size=20&pause=1000&color=FF9900&center=true&vCenter=true&width=560&lines=Custom+VPC+%7C+Public+%26+Private+Subnets;NAT+Gateway+%7C+Multi-AZ+Design;Modular+%26+Reusable+Terraform+Code;Deployed+on+AWS+ap-south-1+(Mumbai)" alt="Typing SVG" />

<br/>

![Terraform](https://img.shields.io/badge/Terraform-IaC-844FBA?style=for-the-badge&logo=terraform&logoColor=white)
![AWS](https://img.shields.io/badge/AWS-Cloud-FF9900?style=for-the-badge&logo=amazonaws&logoColor=white)
![Region](https://img.shields.io/badge/Region-ap--south--1-232F3E?style=for-the-badge&logo=amazonaws&logoColor=white)
![Status](https://img.shields.io/badge/Status-In%20Progress-yellow?style=for-the-badge)
![License](https://img.shields.io/badge/License-MIT-blue?style=for-the-badge)

</div>

---

## 📖 Table of Contents

- [Overview](#-project-overview)
- [Architecture](#️-project-architecture)
- [Tech Stack](#️-technologies-used)
- [Project Structure](#-project-structure)
- [Network Configuration](#-network-configuration)
- [Security Design](#-security-design)
- [Terraform Modules](#-terraform-modules)
- [Deployment](#-terraform-deployment)
- [Verify Infrastructure](#-verify-infrastructure)
- [Destroy Infrastructure](#-destroy-infrastructure)
- [Best Practices](#-terraform-best-practices)
- [Future Improvements](#-future-improvements)
- [Learning Objectives](#-learning-objectives)
- [Author](#-author)

---

## 📌 Project Overview

This project provisions AWS infrastructure using **Terraform** with a modular and reusable architecture.

The objective is to build a production-style AWS networking environment with:

- ✅ Custom VPC
- ✅ Public and Private Subnets
- ✅ Multiple Availability Zones
- ✅ Internet Gateway
- ✅ NAT Gateway
- ✅ Route Tables
- ✅ Security Groups
- ✅ EC2 Instances
- ✅ Reusable Terraform Modules

The infrastructure is designed using **Infrastructure as Code (IaC)** principles — every resource is versioned, repeatable, and destroyable with a single command.

---

## 🏗️ Project Architecture

```text
                              🌍 Internet
                                  │
                                  │
                          🚪 Internet Gateway
                                  │
        ┌─────────────────────────┴─────────────────────────┐
        │                     VPC — 10.0.0.0/16               │
        │                                                     │
        │   ┌───────────────────┐     ┌───────────────────┐   │
        │   │  Public  AZ-a     │     │  Public  AZ-b     │   │
        │   │  10.0.1.0/24      │     │  10.0.2.0/24      │   │
        │   │                   │     │                   │   │
        │   │   🔁 NAT Gateway  │     │                   │   │
        │   └─────────┬─────────┘     └─────────┬─────────┘   │
        │             │                          │             │
        │   ┌─────────┴─────────┐     ┌─────────┴─────────┐   │
        │   │  Private AZ-a     │     │  Private AZ-b     │   │
        │   │  10.0.11.0/24     │     │  10.0.12.0/24     │   │
        │   │                   │     │                   │   │
        │   │   🖥️ EC2 Instance │     │   🖥️ EC2 Instance │   │
        │   └───────────────────┘     └───────────────────┘   │
        └─────────────────────────────────────────────────────┘
```

---

## 🛠️ Technologies Used

<div align="left">

![Terraform](https://img.shields.io/badge/Terraform-844FBA?style=flat-square&logo=terraform&logoColor=white)
![AWS](https://img.shields.io/badge/AWS-FF9900?style=flat-square&logo=amazonaws&logoColor=white)
![VPC](https://img.shields.io/badge/Amazon%20VPC-232F3E?style=flat-square&logo=amazonaws&logoColor=white)
![EC2](https://img.shields.io/badge/Amazon%20EC2-FF9900?style=flat-square&logo=amazonec2&logoColor=white)
![Linux](https://img.shields.io/badge/Linux-FCC624?style=flat-square&logo=linux&logoColor=black)
![Git](https://img.shields.io/badge/Git-F05032?style=flat-square&logo=git&logoColor=white)
![GitHub](https://img.shields.io/badge/GitHub-181717?style=flat-square&logo=github&logoColor=white)

</div>

- Amazon VPC, Amazon EC2, Security Groups
- Internet Gateway, NAT Gateway, Route Tables
- Terraform (modular design)
- Linux, Git & GitHub

---

## 📂 Project Structure

```text
terraform/
│
├── main.tf
├── providers.tf
├── variables.tf
├── outputs.tf
├── terraform.tfvars
├── .gitignore
├── README.md
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

## 🌎 AWS Region

> **ap-south-1** — Mumbai Region 🇮🇳

---

## 🌐 Network Configuration

### VPC

| Attribute | Value |
|---|---|
| CIDR Block | `10.0.0.0/16` |

### Public Subnets

| Availability Zone | CIDR |
|---|---|
| ap-south-1a | `10.0.1.0/24` |
| ap-south-1b | `10.0.2.0/24` |

### Private Subnets

| Availability Zone | CIDR |
|---|---|
| ap-south-1a | `10.0.11.0/24` |
| ap-south-1b | `10.0.12.0/24` |

---

## 🔐 Security Design

The infrastructure separates public and private resources for defense in depth.

| Layer | Internet Access |
|---|---|
| 🌐 Public Subnet | Routed via Internet Gateway |
| 🔒 Private Subnet | No direct inbound access — outbound only via NAT Gateway |

### Security Groups

| Port | Purpose |
|---|---|
| 22 | SSH |
| 80 | HTTP |
| 443 | HTTPS |

> Only the ports required by the application should be opened.

---

## 📦 Terraform Modules

| Module | Responsibilities |
|---|---|
| **`vpc`** | VPC, public/private subnets, Internet Gateway, NAT Gateway, route tables & routes |
| **`security_group`** | EC2 security groups, inbound/outbound rules |
| **`ec2`** | Instance configuration, AMI, instance type, key pair, subnet placement, SG association |

---

## 🚀 Terraform Deployment

```bash
# 1. Initialize Terraform
terraform init

# 2. Format Terraform files
terraform fmt -recursive

# 3. Validate configuration
terraform validate

# 4. Create execution plan
terraform plan

# 5. Apply infrastructure
terraform apply
```

Type `yes` when Terraform asks for confirmation. ✅

---

## 🔍 Verify Infrastructure

After deployment, verify resources from the **AWS Console**:

```text
VPC
├── Subnets
├── Route Tables
├── Internet Gateway
├── NAT Gateway
├── Security Groups
└── EC2 Instances
```

Or verify via the Terraform state:

```bash
terraform state list
```

---

## 🧹 Destroy Infrastructure

```bash
terraform destroy
```

Confirm with `yes` when prompted.

> ⚠️ **Warning:** `terraform destroy` permanently removes all Terraform-managed resources. Use with care.

---

## 🔒 Terraform Best Practices

- 🧱 Modular Terraform structure with reusable modules
- 🔧 Variables instead of hard-coded values
- 📤 Outputs for important resource information
- 🌐 Separate public and private networking
- 🗺️ Multiple Availability Zones for resilience
- 🛡️ Security Groups for network access control
- ✅ `terraform fmt` and `terraform validate` before every apply
- 🔀 Git version control with `.gitignore` for Terraform artifacts
- 🚫 No AWS credentials stored in Terraform files

---



## 🎯 Learning Objectives

```text
AWS Networking → VPC → Subnets → Route Tables
→ Internet Gateway / NAT Gateway → Security Groups
→ EC2 → Terraform Modules → Infrastructure as Code
```

This project demonstrates practical, hands-on knowledge of building secure, modular AWS networking with Terraform.

---

## 👨‍💻 Author

<div align="center">

**Ajay Dhadi**

AWS | DevOps | Terraform | Linux | Docker | Kubernetes

![AWS](https://img.shields.io/badge/AWS-FF9900?style=flat-square&logo=amazonaws&logoColor=white)
![DevOps](https://img.shields.io/badge/DevOps-2496ED?style=flat-square&logo=docker&logoColor=white)
![Kubernetes](https://img.shields.io/badge/Kubernetes-326CE5?style=flat-square&logo=kubernetes&logoColor=white)

</div>

---

## 📌 Project Status

**🚧 In Progress** — the infrastructure is being developed incrementally toward a production-style AWS architecture using Terraform.

<div align="center">

⭐ **If you find this project useful, consider giving it a star!** ⭐

</div>
