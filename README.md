<div align="center">

# ☁️ Terraform AWS EC2 + Security Group 🚀

**Modular Infrastructure as Code to spin up an EC2 instance on AWS — in seconds.**

[![Terraform](https://img.shields.io/badge/Terraform-7B42BC?style=for-the-badge&logo=terraform&logoColor=white)](https://terraform.io)
[![AWS](https://img.shields.io/badge/AWS-232F3E?style=for-the-badge&logo=amazonaws&logoColor=white)](https://aws.amazon.com)
[![Region](https://img.shields.io/badge/Region-ap--south--1-FF9900?style=for-the-badge&logo=amazonec2&logoColor=white)](#)
[![License](https://img.shields.io/badge/License-MIT-green?style=for-the-badge)](#-license)

</div>

---

## 📌 Overview

This project provisions a **single AWS EC2 instance** together with a **dedicated Security Group**, using clean, reusable Terraform modules. Everything is defined as code — no clicking around the AWS Console. 🖱️❌

| 🔹 | Detail |
|----|--------|
| 🌍 **Region** | `ap-south-1` (Mumbai) |
| 💻 **Instance Type** | `t2.micro` (Free Tier eligible) |
| 🔐 **Access** | SSH on port `22` |
| 🧩 **Structure** | Root module → `ec2` + `security_group` child modules |

---

## 🗂️ Project Structure

```
📦 terraform
 ┣ 📜 main.tf              # 🔗 Wires the ec2 & security_group modules together
 ┣ 📜 variables.tf         # 🎛️  Root-level input variables
 ┣ 📜 outputs.tf           # 📤 Root-level outputs
 ┣ 📜 provider.tf          # ☁️  AWS provider configuration
 ┗ 📂 module
    ┣ 📂 ec2               # 💻 EC2 instance module
    ┃  ┣ 📜 main.tf
    ┃  ┣ 📜 variables.tf
    ┃  ┗ 📜 outputs.tf
    ┗ 📂 security_group    # 🔥 Security group module
       ┣ 📜 main.tf
       ┣ 📜 variables.tf
       ┗ 📜 outputs.tf
```

> 💡 Tweak the file names above if yours differ.

---

## 🏗️ What Gets Created

### 🔥 `aws_security_group` — `terraform-ec2-sg`
- ✅ **Inbound:** SSH (TCP `22`) from `0.0.0.0/0`
- ✅ **Outbound:** All traffic allowed (`-1`)
- 🏷️ Tagged: `Name = terraform-ec2-sg`

### 💻 `aws_instance` — `my_terraform_instance`
- 🖥️ Type: `t2.micro`
- 🌐 Public IP: auto-assigned
- 💾 Root volume: `8 GB` `gp3`
- 🔑 Key pair attached for SSH
- 🏷️ Tagged: `Name = my_terraform_instance`

---

## ✅ Prerequisites

| ✔️ | Requirement |
|----|-------------|
| 🧰 | [Terraform](https://developer.hashicorp.com/terraform/downloads) **v1.x+** |
| 👤 | An **AWS account** with programmatic access |
| 🔧 | AWS CLI configured → `aws configure` |
| 🔑 | An existing **EC2 Key Pair** in `ap-south-1` |

---

## ⚡ Quick Start

### 1️⃣ Clone the repository
```bash
git clone <your-repo-url>
cd terraform
```

### 2️⃣ Initialize Terraform
```bash
terraform init
```
> ⬇️ Downloads the AWS provider and sets up the modules.

### 3️⃣ Preview the changes
```bash
terraform plan
```
> 👀 Shows exactly what will be created — nothing is applied yet.

### 4️⃣ Deploy 🚀
```bash
terraform apply
```
> ⌨️ Type `yes` to confirm.

### 5️⃣ Tear it all down 🧹
```bash
terraform destroy
```
> ⚠️ Type `yes` to confirm. **There is no undo!**

---

## 🎛️ Input Variables

| 🏷️ Name | 📝 Description | 🔠 Type | ⚙️ Default |
|---------|----------------|---------|------------|
| `region` | AWS region to deploy into | `string` | `ap-south-1` |
| `ami` | AMI ID for the EC2 instance | `string` | — |
| `instance_type` | EC2 instance size | `string` | `t2.micro` |
| `key_name` | Existing AWS key pair name | `string` | — |

> 📌 Update to match the actual variables in your `variables.tf`.

---

## 📤 Outputs

| 🏷️ Output | 📝 Description |
|-----------|----------------|
| 🆔 `instance_id` | ID of the created EC2 instance |
| 🌐 `public_ip` | Public IP address of the instance |
| 🔐 `security_group_id` | ID of the created security group |

---

## 🔌 Connect to Your Instance

```bash
ssh -i /path/to/your-key.pem ubuntu@<public_ip>
```
> 💡 Use `ec2-user` instead of `ubuntu` for Amazon Linux AMIs.

---

## 🛡️ Security Warning

> ⚠️ **Heads up!** The security group currently allows SSH from `0.0.0.0/0` — that's **the entire internet**. 🌍

For anything beyond quick testing, lock it down to your own IP:

```hcl
ingress {
  description = "SSH"
  from_port   = 22
  to_port     = 22
  protocol    = "tcp"
  cidr_blocks = ["<your-public-ip>/32"]  # 🔒 Much safer
}
```

---

## 💰 Cost Note

💵 `t2.micro` is **AWS Free Tier eligible** (750 hrs/month for the first 12 months). Still — always run `terraform destroy` when you're done to avoid surprise charges! 🧾

---

## 🤝 Contributing

Contributions are welcome! 🎉

1. 🍴 Fork the repo
2. 🌿 Create a branch → `git checkout -b feature/amazing-feature`
3. 💾 Commit → `git commit -m "Add amazing feature"`
4. 🚀 Push → `git push origin feature/amazing-feature`
5. 🔃 Open a Pull Request

---

## 📄 License

📝 Licensed under the **MIT License** — see the [LICENSE](LICENSE) file for details.

---

<div align="center">

### ⭐ If this helped you, consider giving the repo a star!

Made with ❤️ and ☁️ using **Terraform**

</div>
