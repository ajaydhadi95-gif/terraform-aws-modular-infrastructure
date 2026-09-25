<div align="center">

# 🚀 3-Tier AWS Application Architecture using Terraform

### Frontend • Backend • Database — segmented, secured, and provisioned as code

<img src="https://readme-typing-svg.demolab.com?font=Fira+Code&size=20&pause=1000&color=FF9900&center=true&vCenter=true&width=600&lines=Public+Frontend+%7C+Private+Backend+%2B+Database;Least-Privilege+Security+Groups;Modular+%26+Reusable+Terraform+Code;Deployed+on+AWS+ap-south-1+(Mumbai)" alt="Typing SVG" />

<br/>

![Terraform](https://img.shields.io/badge/Terraform-IaC-844FBA?style=for-the-badge&logo=terraform&logoColor=white)
![AWS](https://img.shields.io/badge/AWS-Cloud-FF9900?style=for-the-badge&logo=amazonaws&logoColor=white)
![Architecture](https://img.shields.io/badge/Architecture-3--Tier-0EA5E9?style=for-the-badge)
![Status](https://img.shields.io/badge/Status-In%20Progress-yellow?style=for-the-badge)
![License](https://img.shields.io/badge/License-MIT-blue?style=for-the-badge)

</div>

---

## 📖 Table of Contents

- [Overview](#-project-overview)
- [Architecture](#️-architecture)
- [Network Architecture](#-network-architecture)
- [Application Traffic Flow](#-application-traffic-flow)
- [Security Group Design](#-security-group-design)
- [Tech Stack](#️-technologies-used)
- [Project Structure](#-terraform-project-structure)
- [AWS Components](#️-aws-components)
- [Deployment](#-terraform-deployment)
- [Verify Infrastructure](#-verify-infrastructure)
- [Destroy Infrastructure](#-destroy-infrastructure)
- [Security Principles](#-security-principles)
- [Production Improvements](#-production-improvements)
- [Project Objectives](#-project-objectives)
- [Author](#-author)

---

## 📌 Project Overview

This project demonstrates a **3-Tier Application Architecture on AWS** using **Terraform**.

The application is divided into three separate layers:

| # | Layer | Placement |
|---|---|---|
| 1️⃣ | **Frontend** | Public Subnet |
| 2️⃣ | **Backend** | Private Subnet |
| 3️⃣ | **Database** | Private Subnet |

The architecture follows network segmentation principles: the frontend is reachable from the Internet, while backend and database resources stay inside private subnets.

---

## 🏗️ Architecture

```text
                              🌍 Internet
                                  │
                             80 / 443
                                  ▼
                         ┌─────────────────┐
                         │    FRONTEND     │
                         │  10.0.1.0/24    │
                         │  Public Subnet  │
                         └────────┬────────┘
                                  │
                               8080
                                  ▼
                         ┌─────────────────┐
                         │     BACKEND     │
                         │  10.0.11.0/24   │
                         │ Private Subnet  │
                         └────────┬────────┘
                                  │
                               3306
                                  ▼
                         ┌─────────────────┐
                         │    DATABASE     │
                         │  10.0.12.0/24   │
                         │ Private Subnet  │
                         └─────────────────┘
```

---

## 🌐 Network Architecture

```text
VPC — 10.0.0.0/16
│
├── 🌐 Public Subnet
│   └── Frontend        10.0.1.0/24
│
├── 🔒 Private Subnet
│   └── Backend         10.0.11.0/24
│
└── 🔒 Private Subnet
    └── Database         10.0.12.0/24
```

---

## 🔄 Application Traffic Flow

| Step | Flow | Port | Notes |
|---|---|---|---|
| 1 | Internet → Frontend | `80 / 443` | Frontend sits in a **public subnet** to receive user traffic |
| 2 | Frontend → Backend | `8080` | Backend sits in a **private subnet**, not exposed to the Internet |
| 3 | Backend → Database | `3306` | Standard MySQL port; database sits in a **private subnet** |

---

## 🔐 Security Group Design

Security Groups allow only the traffic each layer actually needs.

### 🌐 Frontend Security Group

```text
Inbound:
  HTTP   → 80    (0.0.0.0/0)
  HTTPS  → 443   (0.0.0.0/0)
```

### 🔒 Backend Security Group

```text
Inbound:
  TCP → 8080
  Source → Frontend Security Group
```

> 🚫 Avoid `0.0.0.0/0 → 8080` — the backend must never be directly reachable from the Internet.

### 🔒 Database Security Group

```text
Inbound:
  TCP → 3306
  Source → Backend Security Group
```

> 🚫 Avoid `0.0.0.0/0 → 3306` — the database must never be publicly accessible.

---

## 🛠️ Technologies Used

<div align="left">

![Terraform](https://img.shields.io/badge/Terraform-844FBA?style=flat-square&logo=terraform&logoColor=white)
![AWS](https://img.shields.io/badge/AWS-FF9900?style=flat-square&logo=amazonaws&logoColor=white)
![VPC](https://img.shields.io/badge/Amazon%20VPC-232F3E?style=flat-square&logo=amazonaws&logoColor=white)
![EC2](https://img.shields.io/badge/Amazon%20EC2-FF9900?style=flat-square&logo=amazonec2&logoColor=white)
![MySQL](https://img.shields.io/badge/MySQL-4479A1?style=flat-square&logo=mysql&logoColor=white)
![Linux](https://img.shields.io/badge/Linux-FCC624?style=flat-square&logo=linux&logoColor=black)
![Git](https://img.shields.io/badge/Git-F05032?style=flat-square&logo=git&logoColor=white)
![GitHub](https://img.shields.io/badge/GitHub-181717?style=flat-square&logo=github&logoColor=white)

</div>

- Amazon VPC, EC2, Security Groups, Subnets, Route Tables
- Internet Gateway, NAT Gateway
- Frontend Application, Backend Application, MySQL
- Linux, Git & GitHub

---

## 📂 Terraform Project Structure

```text
terraform/
│
├── main.tf
├── providers.tf
├── variables.tf
├── outputs.tf
├── terraform.tfvars
├── README.md
├── .gitignore
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

## ☁️ AWS Components

| Layer | Component | Network |
|---|---|---|
| Frontend | EC2 / Application | Public Subnet |
| Backend | EC2 / Application | Private Subnet |
| Database | MySQL | Private Subnet |
| Network | VPC | `10.0.0.0/16` |
| Frontend | Port 80/443 | Internet → Frontend |
| Backend | Port 8080 | Frontend → Backend |
| Database | Port 3306 | Backend → Database |

---

## 🚀 Terraform Deployment

```bash
# Initialize Terraform
terraform init

# Format Terraform files
terraform fmt -recursive

# Validate configuration
terraform validate

# Create Terraform plan
terraform plan

# Deploy infrastructure
terraform apply
```

Confirm with `yes` when prompted. ✅

---

## 🔍 Verify Infrastructure

```text
VPC
│
├── Public Subnet
│   └── Frontend
│
├── Private Subnet
│   └── Backend
│
├── Private Subnet
│   └── Database
│
├── Internet Gateway
├── NAT Gateway
├── Route Tables
└── Security Groups
```

Or check via Terraform state:

```bash
terraform state list
```

---

## 🧹 Destroy Infrastructure

```bash
terraform destroy
```

Confirm with `yes` when prompted.

> ⚠️ **Warning:** `terraform destroy` permanently removes all Terraform-managed AWS resources.

---

## 🔒 Security Principles

- 🌐 Frontend is publicly accessible
- 🔒 Backend is isolated in a private subnet
- 🔒 Database is isolated in a private subnet
- 🔁 Backend accepts traffic **only** from the frontend layer
- 🔁 Database accepts traffic **only** from the backend layer
- 🚫 Port `3306` is never exposed to the Internet
- 🚫 Port `8080` is never exposed to the Internet
- 🛡️ Security Groups enforce least-privilege network access
- 🔀 Private resources reach the Internet (for updates etc.) only via NAT Gateway

---

## 📈 Production Improvements

```text
Internet
   │
   ▼
Route 53
   │
   ▼
Application Load Balancer
   │
   ▼
Frontend / Web Tier
   │
   ▼
Backend / Application Tier
   │
   ▼
RDS MySQL
```

- [ ] Application Load Balancer
- [ ] Auto Scaling Group
- [ ] Multiple Availability Zones
- [ ] Amazon RDS
- [ ] Route 53
- [ ] ACM SSL Certificate
- [ ] CloudWatch + VPC Flow Logs
- [ ] IAM Roles
- [ ] NAT Gateway per AZ
- [ ] S3 Terraform Remote Backend
- [ ] CI/CD with Jenkins
- [ ] Docker & Kubernetes / EKS

---

## 🎯 Project Objectives

- Understand AWS VPC networking
- Implement public and private subnet architecture
- Deploy a 3-tier application
- Understand traffic flow between application layers
- Configure Security Groups using least-privilege access
- Provision infrastructure using Terraform
- Use reusable Terraform modules
- Practice production-style AWS architecture

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

**🚧 In Progress** — being developed as a Terraform-based **3-Tier AWS Application Architecture** with separate frontend, backend, and database network layers.

<div align="center">

⭐ **If you find this project useful, consider giving it a star!** ⭐

</div>
