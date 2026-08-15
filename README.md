# Terraform + Ansible Azure Automation Project

**Course:** CCGC 5502 Automation  
**Humber ID:** n01276909

## Project Overview

This project integrates **Terraform and Ansible** to provide end-to-end infrastructure provisioning and configuration management in Microsoft Azure.

Terraform provisions the Azure infrastructure using a modular and parameterized architecture. After the infrastructure is created, a Terraform `null_resource` with a `local-exec` provisioner automatically executes the Ansible playbook against all Linux virtual machines.

The complete deployment is designed to run non-interactively using:

```bash
terraform apply --auto-approve
```

---

## Project Objectives

The project demonstrates:

- Infrastructure provisioning using Terraform
- Configuration management using Ansible
- Terraform and Ansible integration
- Modular Terraform architecture
- Heavy input parameterization
- Scalable Linux and Windows VM deployment
- Automated user and group management
- Automated Linux profile configuration
- Automated disk partitioning and mounting
- Automated Apache web server configuration
- HTTP load balancing across multiple Linux web servers
- Remote Terraform state management using Azure Storage

---

## Terraform Features

- Azure remote backend for Terraform state
- Modular Terraform architecture
- Parameterized root and child modules
- Common tagging using Terraform locals
- Linux VM deployment using `for_each`
- Windows VM deployment using `count`
- Availability sets for Linux and Windows virtual machines
- Managed data disks attached to virtual machines
- Public Azure Load Balancer
- HTTP health probe
- HTTP load-balancing rule
- PostgreSQL Flexible Server
- Azure monitoring extensions
- Terraform outputs for infrastructure information
- Terraform and Ansible integration using `null_resource` and `local-exec`

---

## Azure Infrastructure

The Terraform configuration provisions the following Azure resources:

- Resource Group
- Virtual Network
- Subnet
- Network Security Group
- Network Security Rules
- Log Analytics Workspace
- Recovery Services Vault
- Standard LRS Storage Account
- 3 Linux Virtual Machines
- 1 Windows Virtual Machine
- Linux Availability Set
- Windows Availability Set
- Public IP addresses
- Network Interfaces
- Managed Data Disks
- Azure Load Balancer
- Load Balancer Backend Pool
- HTTP Health Probe
- HTTP Load-Balancing Rule
- PostgreSQL Flexible Server

---

## Linux Virtual Machines

Three Linux virtual machines are deployed using Terraform `for_each`.

The final implementation uses:

- Red Hat Enterprise Linux 8
- SSH key authentication
- Unique DNS labels
- Unique FQDNs
- Azure Monitor Agent
- Network Watcher Agent
- Managed data disks
- Boot diagnostics

RHEL 8 was used because the Azure Monitor Agent did not support the original CentOS 8 image during the final deployment.

---

## Windows Virtual Machine

The Windows virtual machine is deployed using Terraform `count`.

The Windows configuration includes:

- Windows Server 2016
- Windows Availability Set
- Public IP address
- Unique DNS label
- Network Interface
- Managed data disk
- Microsoft Antimalware extension
- Boot diagnostics

---

## Ansible Automation

Ansible automatically configures all Linux inventory nodes after Terraform completes the Azure infrastructure deployment.

The main Ansible playbook is:

```text
ansible/n01276909-playbook.yml
```

The playbook executes four Ansible roles:

1. `profile-n01276909`
2. `user-n01276909`
3. `datadisk-n01276909`
4. `webserver-n01276909`

---

## Profile Role

Role:

```text
profile-n01276909
```

The profile role updates the system-wide `/etc/profile` file.

The following configuration is added:

```text
#Test block added by Ansible......n01276909
export TMOUT=1500
```

This configuration is managed using the Ansible `blockinfile` module.

---

## User Role

Role:

```text
user-n01276909
```

The user role performs the following configuration:

- Creates the `cloudadmins` group
- Creates `user100`
- Creates `user200`
- Creates `user300`
- Adds all three users to the `cloudadmins` group
- Adds all three users to the `wheel` group
- Generates SSH key pairs without passphrases
- Downloads the private key for `user100` from VM1 to the automation machine

The downloaded private key is excluded from Git using `.gitignore`.

---

## Data Disk Role

Role:

```text
datadisk-n01276909
```

The data disk role configures the Linux data disk with two partitions.

### Partition 1

- Mount point: `/part1`
- Approximate size: 4 GB
- Filesystem: XFS
- Persistent mount

### Partition 2

- Mount point: `/part2`
- Approximate size: 5 GB
- Filesystem: EXT4
- Persistent mount

The required entries are automatically maintained for persistent mounting.

---

## Web Server Role

Role:

```text
webserver-n01276909
```

The web server role performs the following tasks:

- Installs Apache HTTP Server
- Enables Apache
- Starts Apache
- Uses an Ansible handler to restart Apache
- Creates VM-specific HTML files on the automation machine
- Copies the correct file to each Linux VM as `index.html`
- Stores the page under `/var/www/html`
- Sets web page permissions to `0444`
- Enables HTTP access through RHEL `firewalld`
- Ensures Apache automatically starts after reboot

The HTML page on each Linux VM displays the FQDN of that respective VM.

---

## Terraform and Ansible Integration

Terraform and Ansible are integrated using a root-level Terraform `null_resource`.

The Terraform `local-exec` provisioner:

1. Waits for the Linux virtual machines to become reachable.
2. Generates the Ansible inventory.
3. Checks SSH connectivity.
4. Executes the Ansible playbook automatically.
5. Configures all Linux virtual machines.

The workflow is:

```text
terraform apply --auto-approve
        |
        v
Terraform provisions Azure infrastructure
        |
        v
Linux VMs become reachable through SSH
        |
        v
Terraform generates Ansible inventory
        |
        v
Ansible playbook starts automatically
        |
        v
Profile Role
        |
        v
User Role
        |
        v
Data Disk Role
        |
        v
Web Server Role
        |
        v
Configuration completes
```

This provides a non-interactive infrastructure and configuration deployment process.

---

## Load Balancer Configuration

The public Azure Load Balancer distributes HTTP requests across all three Linux web servers.

The load balancer configuration includes:

- Public IP address
- Azure DNS label
- Frontend IP configuration
- Backend address pool
- Three Linux network interfaces in the backend pool
- HTTP health probe
- HTTP load-balancing rule
- Port 80 traffic distribution

The final load balancer FQDN follows this format:

```text
lb6909linda.centralus.cloudapp.azure.com
```

The web application is accessed using HTTP:

```text
http://lb6909linda.centralus.cloudapp.azure.com
```

During validation, refreshing the browser returns pages from different backend Linux virtual machines.

Example responses include:

```text
linux6909linda1.centralus.cloudapp.azure.com
linux6909linda2.centralus.cloudapp.azure.com
linux6909linda3.centralus.cloudapp.azure.com
```

This confirms successful load-balanced traffic distribution.

---

## Project Structure

```text
terraform-ansible-project-n01276909/
├── ansible/
│   ├── ansible.cfg
│   ├── inventory.ini
│   ├── n01276909-playbook.yml
│   └── roles/
│       ├── profile-n01276909/
│       │   ├── defaults/
│       │   ├── tasks/
│       │   └── vars/
│       │
│       ├── user-n01276909/
│       │   ├── defaults/
│       │   ├── tasks/
│       │   └── vars/
│       │
│       ├── datadisk-n01276909/
│       │   ├── defaults/
│       │   ├── tasks/
│       │   └── vars/
│       │
│       └── webserver-n01276909/
│           ├── defaults/
│           ├── handlers/
│           ├── tasks/
│           └── vars/
│
├── modules/
│   ├── common-6909/
│   ├── database-6909/
│   ├── datadisk-6909/
│   ├── loadbalancer-6909/
│   ├── network-6909/
│   ├── rgroup-6909/
│   ├── vmlinux-6909/
│   └── vmwindows-6909/
│
├── backend.tf
├── locals.tf
├── main.tf
├── outputs.tf
├── providers.tf
├── provisioner.tf
├── variables.tf
├── versions.tf
├── .gitignore
└── README.md
```

---

## Terraform Backend

Terraform state is stored remotely using an Azure Storage backend.

Remote state provides centralized and persistent Terraform state management.

Sensitive Terraform state files are not committed to GitHub.

---

## Parameterization

The Terraform configuration uses input variables extensively to avoid hardcoded deployment-specific values.

Examples of parameterized values include:

- Azure subscription
- Azure region
- Resource names
- Resource prefix
- VM sizes
- VM names
- DNS labels
- Network addresses
- Storage settings
- Linux image configuration
- Windows image configuration
- Data disk settings
- PostgreSQL configuration
- Load balancer DNS label
- Network security rules

Terraform values are primarily supplied through:

```text
variables.tf
terraform.tfvars
```

The `terraform.tfvars` file contains environment-specific and sensitive values and is excluded from GitHub.

Ansible roles are also parameterized using role defaults and variables.

---

## Terraform Commands

### Initialize Terraform

```bash
terraform init
```

### Format Terraform Code

```bash
terraform fmt -recursive
```

### Validate Terraform Configuration

```bash
terraform validate
```

### Review Terraform Plan

```bash
terraform plan
```

### Deploy Infrastructure

```bash
terraform apply --auto-approve
```

Terraform automatically starts the Ansible configuration process during deployment.

### Display Terraform State

```bash
terraform state list | nl
```

### Display Terraform Outputs

```bash
terraform output
```

### Destroy Infrastructure

```bash
terraform destroy --auto-approve
```

---

## Ansible Commands

Change to the Ansible directory:

```bash
cd ansible
```

### Display Inventory

```bash
ansible-inventory --graph
```

### Validate Playbook Syntax

```bash
ansible-playbook n01276909-playbook.yml --syntax-check
```

### Run the Playbook Manually for Testing

```bash
ansible-playbook n01276909-playbook.yml
```

During normal infrastructure provisioning, manual execution is not required because Terraform automatically executes the playbook.

---

## Configuration Validation

After deployment, configuration can be validated by logging into VM1 using `user100`.

The login uses the downloaded SSH private key and does not require a password or passphrase.

The following commands are used for validation.

### Validate Profile Configuration

```bash
tail -4 /etc/profile
```

### Validate Created Users

```bash
tail -4 /etc/passwd
```

### Validate Group Membership

```bash
grep -E 'cloudadmins|wheel' /etc/group
```

### Validate Disk Configuration

```bash
df -Th
```

The disk output confirms:

```text
/part1    xfs
/part2    ext4
```

---

## Web Server Validation

The load-balanced website can be accessed through the load balancer FQDN:

```text
http://lb6909linda.centralus.cloudapp.azure.com
```

Refreshing the browser sends requests to different Linux web servers.

The backend nodes display their respective FQDNs, demonstrating successful load balancing.

---

## Security

Sensitive and generated files are excluded from Git using `.gitignore`.

Excluded files include:

```text
terraform.tfvars
*.tfstate
*.tfstate.*
.terraform/
tfplan
*.tfplan
ansible/downloaded_keys/
ansible/vm*.html
PROJECT_Report_Ansible.docx
```

SSH private keys, Terraform variable files, Terraform state files, Terraform plan files, and local project documentation are not stored in the public GitHub repository.

---

## Deployment Notes

- Azure resources are deployed in the `centralus` region.
- PostgreSQL Flexible Server is used because Azure Database for PostgreSQL Single Server has been retired.
- RHEL 8 is used for the Linux virtual machines.
- RHEL 8 replaced the original CentOS 8 image because the Azure Monitor Agent failed on the unsupported CentOS 8 image.
- HTTP access through RHEL `firewalld` is automatically configured by Ansible.
- Terraform automatically executes Ansible after infrastructure provisioning.
- The load balancer configuration includes an HTTP health probe and load-balancing rule.
- Infrastructure should be destroyed after project evaluation to prevent unnecessary Azure charges.

---

## Final Validation

The final implementation successfully demonstrates:

- Terraform infrastructure deployment
- Terraform remote backend
- Heavy parameterization
- Modular Terraform code
- Scalable VM deployment
- Automatic Terraform and Ansible integration
- Passwordless user authentication
- User and group management
- System-wide profile configuration
- Linux disk partitioning and persistent mounting
- Apache web server deployment
- RHEL firewall configuration
- Load-balanced HTTP traffic across three Linux VMs
- Non-interactive automated provisioning

---
