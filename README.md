# Terraform Azure Infrastructure Automation Project

This project deploys a modular Azure infrastructure using Terraform for the CCGC 5502 Automation assignment.

## Project Overview

The project provisions Azure infrastructure using Terraform modules, remote backend, parameterized variables, locals for tags, scalable VM deployment, data disks, load balancer, monitoring services, and database.

## Features

- Azure remote backend for Terraform state
- Modular Terraform architecture
- Resource group module
- Network module with VNet, subnet, NSG, and security rules
- Common services module:
  - Log Analytics Workspace
  - Recovery Services Vault
  - Storage Account
- Linux VM module using for_each
- Windows VM module using count
- Availability sets for Linux and Windows VMs
- Linux VM extensions:
  - Network Watcher Agent
  - Azure Monitor Agent
- Windows Antimalware extension
- Remote-exec provisioner to display Linux hostnames
- Data disks attached to all VMs
- Public Load Balancer for Linux VMs
- PostgreSQL Flexible Server database
- Terraform outputs for hostnames, FQDNs, IP addresses, load balancer, and database

## Terraform Commands

```bash
terraform init
terraform fmt
terraform validate
terraform plan
terraform apply -auto-approve
terraform state list | nl
terraform output
terraform destroy -auto-approve

Notes
Standard_D2s_v3 was used because smaller VM sizes were unavailable in Central US due to Azure capacity restrictions.
PostgreSQL Flexible Server was used because PostgreSQL Single Server is retired.
Sensitive files such as terraform.tfvars, state files, and .terraform/ are excluded using .gitignore.
EOF