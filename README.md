# Automating AWS EC2 Deployment with Grafana & Let's Encrypt

Automated end-to-end deployment of a **Grafana server on AWS EC2** using:

- **[Terraform](https://www.terraform.io/)** – Infrastructure provisioning  
- **[Amazon Web Services (AWS)](https://aws.amazon.com/)** – Cloud infrastructure  
- **[Ansible](https://www.ansible.com/)** – Configuration management  
- **[Grafana](https://grafana.com/)** – Monitoring & visualization  
- **[Let's Encrypt](https://letsencrypt.org/)** – Free shortlived X.509 SSL certificates for IP address 

## Table of Contents

- [What This Project Does](#what-this-project-does)
- [Project Structure](#project-structure)
- [Provisioned AWS Resources](#provisioned-aws-resources)
- [Ansible Configuration](#ansible-configuration)
- [Deployment Steps](#deployment-steps)
- [Final Output](#final-output)


---

## What This Project Does

This repository automates:

1. **Infrastructure provisioning with Terraform**
2. **Dynamic Ansible inventory generation**
3. **Automated Grafana installation**
4. **TLS certificate issuance with Let's Encrypt**
5. **Secure Grafana deployment over HTTPS**

---

## Project Structure

```bash
.
├── terraform/
│   ├── main.tf
│   ├── variables.tf
│   └── provider.tf
├── ansible/
│   ├── playbook.yaml
│   ├── certbot/
│   ├── grafana/
│   ├── ansible.cfg
│   └── inventory (auto-generated)
├──  README.md
├──  .gitignore
└──  LICENCE
```

## Provisioned AWS Resources

Terraform automatically creates:

- ✅ **EC2 Instance** (Debian 13)
- ✅ **Security Group**
  - SSH (22)
  - HTTP (80) – for Certbot challenge
  - Grafana (3000)
- ✅ **SSH Key Pair** (imported from local machine)
- ✅ **Dynamic Ansible inventory file**
- ✅ **Automated Ansible execution via `local-exec`**

---

## Ansible Configuration

The Ansible playbook performs:

- Update APT cache
- Set public IP as fact
- Install Grafana 
- Install Certbot
- Request Let's Encrypt X.509 certificate
- Copy certificate and private key to Grafana directory
- Restart Grafana service

---

## Deployment Steps

### Generate SSH keys
```bash
ssh-keygen -t ed25519 -f ~/.ssh/aws_ec2
```

### Update Terraform Variables
```bash
terraform/variables.tf
```

Set 
* `ec2_ssh_pubkey_path` 
* `ec2_ssh_private_path`

### Run Terraform
```bash
cd terraform

terraform init

terraform plan

terraform apply
```

⚠️ Do not change directory names , the local_exec provisioner uses relative paths to run Ansible.

Terraform will:
* Deploy AWS infrastructure
* Generate Ansible inventory
* Wait for EC2 initialization
* Execute Ansible playbook automatically

## Final Output
After successful deployment, Terraform outputs:
`https://<EC2_PUBLIC_IP>:3000/`
