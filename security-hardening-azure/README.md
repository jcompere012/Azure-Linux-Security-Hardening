# Linux Security Hardening on Azure

A comprehensive security hardening project for Linux systems deployed on Microsoft Azure, implementing industry best practices and automated security testing.

## 🎯 Project Overview

This project demonstrates enterprise-grade security hardening for Linux servers:
- Automated system patching
- SSH hardening with key-based authentication
- Firewall configuration (UFW)
- System auditing with auditd
- Intrusion prevention with Fail2Ban
- Automated security testing suite

## 🏗️ Architecture

- **Platform**: Microsoft Azure
- **OS**: Ubuntu 22.04 LTS
- **Security Tools**: UFW, auditd, Fail2Ban, Lynis, rkhunter
- **Monitoring**: Custom security check scripts

## 🛠️ Technologies Used

- **Cloud Platform**: Microsoft Azure
- **Operating System**: Ubuntu 22.04 LTS
- **Firewall**: UFW (Uncomplicated Firewall)
- **Auditing**: auditd
- **IPS**: Fail2Ban
- **Security Scanning**: Lynis, rkhunter
- **Scripting**: Bash

## 📋 Prerequisites

- Azure account with active subscription
- Basic understanding of Linux command line
- SSH client installed

### 1. Deploy Infrastructure
# Create Azure resources (Resource Group, Virtual Network, Virtual Machine)
- Resource group: security-hardening-rg
- Virtual network: security-vnet
- Virtual Machine: security-linux-vm


### 2. Run Security Hardening
# SSH into the VM
ssh -i security-linux-vm_key.pem azureuser@48.194.95.70

# Update system
sudo apt update && sudo apt upgrade -y

### System Hardening
- ✅ Automatic security updates
- ✅ Minimal service exposure
- ✅ Secure file permissions

### Access Control
- ✅ SSH key-only authentication
- ✅ Root login disabled
- ✅ Multi-factor authentication ready
- ✅ Fail2Ban brute force protection

### Network Security
- ✅ UFW firewall with restrictive rules
- ✅ Azure Network Security Groups
- ✅ DDoS protection considerations
- ✅ Port scanning prevention

### Monitoring & Auditing
- ✅ System auditing with auditd
- ✅ Comprehensive logging
- ✅ Automated security checks

