# Linux VM Hardening Lab Setup

## Create Resourse group
- security-hardening-rg
<img width="1891" height="717" alt="Screenshot 2025-10-30 at 7 25 02 AM" src="https://github.com/user-attachments/assets/0488577a-c968-4c3a-9ad5-5c591392c16e" />

## Create Virtual Network
- security-vnet

## Create Virtual Machine & Network Security Group
- security-linux-vm- ubuntu 22.04 LTS
- download key pair: security-linux-vm_key.pem
<img width="1891" height="889" alt="Screenshot 2025-10-30 at 7 25 23 AM" src="https://github.com/user-attachments/assets/ceff6023-76e3-4109-a772-476d38e5cfd1" />


## Operating system 
- MacOs

### 1. Open terminal 
- cd ~/Downlaods
- chmod 400 security-linux-vm_key.pem
- SSH -i security-linux-vm_key.pem azureuser@48.194.95.70
<img width="842" height="889" alt="Screenshot 2025-10-30 at 7 33 22 AM" src="https://github.com/user-attachments/assets/b64d2d95-e740-4856-9f47-cd0990e6c4c7" />

### 2. System hardening steps

#### Update and Upgrade packages
- sudo apt update && sudo apt upgrade -y
#### Remove unnecessary packages
- sudo apt autoremove -y 
<img width="842" height="949" alt="Screenshot 2025-10-30 at 7 35 45 AM" src="https://github.com/user-attachments/assets/b1d2497d-0102-4bca-887f-a2ef067642c2" />
<img width="842" height="949" alt="Screenshot 2025-10-30 at 7 36 44 AM" src="https://github.com/user-attachments/assets/b543d47c-2b02-4aaf-863c-d4a50ecddde1" />

### 3. Enable automatic security updates
 #### Install unattended-upgrades -y
- sudo apt install unattended-upgrades
- sudo dpkg-reconfigure -plow unattended-upgrades
<img width="842" height="741" alt="Screenshot 2025-10-30 at 7 39 04 AM" src="https://github.com/user-attachments/assets/b490cdcc-b123-4a67-b5d9-6d0ffc241334" />

### 4. List and potentially disable unnecesary services
  - sudo systemctl list-units --type=service --state=running
<img width="1409" height="885" alt="Screenshot 2025-10-30 at 7 44 09 AM" src="https://github.com/user-attachments/assets/5322d546-f554-4ee8-82ab-014f4e8f944e" />

### 5. Configure UFW Firewall and allow port 22 
- sudo apt install ufw -y
- sudo ufw default deny incoming
- sudo ufw default allow outgoing 
- sudo ufw allow 22/tcp
- sudo ufw enable
- sudo ufw status verbose
- sudo ufw loggin on ( log firewall activity)
<img width="1409" height="885" alt="Screenshot 2025-10-30 at 7 48 57 AM" src="https://github.com/user-attachments/assets/7c1d6b52-1f1c-4dd4-b23a-d10ac04f54af" />
<img width="1381" height="898" alt="Screenshot 2025-10-30 at 8 45 52 AM" src="https://github.com/user-attachments/assets/1d408817-ad52-4922-8b5c-c6da19e4a565" />

### 6. SSH Configuration ( disabled and limit access) 
- sudo cp /etc/ssh/sshd_config /etc/ssh/sshd_config.backu
  - PasswordAuthentication no
  - PubkeyAuthentication yes
  - PermitEmptyPasswords no
  - Protocol 2
  - LoginGraceTime 1m
  - MaxAuthTries 3
  - X11Forwarding no
  - ClientAliveInterval 300
  - ClientAliveCountMax 2
- sudo systemctl restart ssh
<img width="1409" height="441" alt="Screenshot 2025-10-30 at 8 05 47 AM" src="https://github.com/user-attachments/assets/f26943a6-79a7-4adc-bf40-ecb5a82e9333" />
<img width="1409" height="885" alt="Screenshot 2025-10-30 at 8 05 21 AM" src="https://github.com/user-attachments/assets/098af89c-b11b-4b1e-8961-98d17d967eb5" />
<img width="1409" height="885" alt="Screenshot 2025-10-30 at 8 05 29 AM" src="https://github.com/user-attachments/assets/1a184e5c-7e43-40e9-9d18-9537ed4efe42" />

### 7. Auditing
- sudo apt install auditd audispd-plugins -y 
- sudo systemctl start auditd
- sudo systemctl enable auditd
- sudo nano /etc/audit/rules.d/hardening.rules
- sudo augenrules --load
- sudo systemctl restart auditd
<img width="1409" height="913" alt="Screenshot 2025-10-30 at 8 09 14 AM" src="https://github.com/user-attachments/assets/a08a31cb-5398-4f47-bee6-eda34ac13d56" />
<img width="1409" height="846" alt="Screenshot 2025-10-30 at 8 12 42 AM" src="https://github.com/user-attachments/assets/7f177d96-b40f-498e-9e4d-0b8cba20c832" />
<img width="1409" height="763" alt="Screenshot 2025-10-30 at 8 11 20 AM" src="https://github.com/user-attachments/assets/67158512-adc6-48f2-8c4f-504f59e85e7f" />
#### Audit test and log 
<img width="1377" height="942" alt="Screenshot 2025-10-30 at 9 59 54 AM" src="https://github.com/user-attachments/assets/86f965c1-283b-437f-bd45-6d6c950814ff" />

### 8. Install and configure Fail2Ban
- sudo apt install fail2ban -y
- sudo cp /etc/fail2ban/jail.conf /etc/fail2ban/jail.local
- sudo nano /etc/fail2ban/jail.local
--  [sshd]
enabled = true
port = 22
filter = sshd
logpath = /var/log/auth.log
maxretry = 3
bantime = 3600
findtime = 600
- sudo systemctl start fail2ban
- sudo systemctl enable fail2ban
<img width="1409" height="953" alt="Screenshot 2025-10-30 at 8 21 21 AM" src="https://github.com/user-attachments/assets/562f6a57-e475-4890-8ed5-1fe900a9e2f7" />
<img width="1409" height="54" alt="Screenshot 2025-10-30 at 8 21 41 AM" src="https://github.com/user-attachments/assets/0ee9c69e-be69-429c-9a50-e3de97bfa023" />
<img width="1409" height="227" alt="Screenshot 2025-10-30 at 8 20 09 AM" src="https://github.com/user-attachments/assets/456be0ea-be9f-45ae-b585-80ef1aff6513" />
<img width="1409" height="280" alt="Screenshot 2025-10-30 at 8 23 08 AM" src="https://github.com/user-attachments/assets/759c30f7-4a19-428a-b696-bedabfb5ebbb" />
#### Testing
<img width="1381" height="558" alt="Screenshot 2025-10-30 at 8 55 23 AM" src="https://github.com/user-attachments/assets/183ce263-6695-44c7-8d06-d0f740961629" />
<img width="1381" height="171" alt="Screenshot 2025-10-30 at 8 55 52 AM" src="https://github.com/user-attachments/assets/e76b9d11-ab31-4269-8ef9-ec9cf834d965" />
<img width="1381" height="308" alt="Screenshot 2025-10-30 at 9 16 58 AM" src="https://github.com/user-attachments/assets/350f7b2f-1442-489f-8231-57069b08ea4b" />

### 9. Set secure file permissions
- sudo chmod 600 /etc/ssh/sshd_config
- sudo chmod 600 /etc/shadow
- sudo chmod 600 /etc/gshadow
- sudo chmod 644 /etc/passwd
- sudo chmod 644 /etc/group
<img width="1409" height="150" alt="Screenshot 2025-10-30 at 8 27 44 AM" src="https://github.com/user-attachments/assets/1be05c20-1e01-4d9f-b914-9220e3fae93e" />

### 10. install lynis( security audit)  and rkhunter (scan for rootkits)
- # Install security scanning tools
- sudo apt install lynis rkhunter chkrootkit -y
- sudo lynis audit system
- sudo rkhunter --check --skip-keypress (rootkits scan)
<img width="1409" height="959" alt="Screenshot 2025-10-30 at 8 33 09 AM" src="https://github.com/user-attachments/assets/d1242d5a-9c78-4515-bd2a-da4b027dd2bf" />
<img width="1409" height="959" alt="Screenshot 2025-10-30 at 8 36 21 AM" src="https://github.com/user-attachments/assets/9dbbab75-5ada-455e-aa4e-5b0077c70952" />
<img width="1409" height="959" alt="Screenshot 2025-10-30 at 8 36 27 AM" src="https://github.com/user-attachments/assets/295b5d3d-90b5-43b0-8381-0abaa40f01bc" />
<img width="1409" height="959" alt="Screenshot 2025-10-30 at 8 36 33 AM" src="https://github.com/user-attachments/assets/83a5640e-863a-4ba4-843b-0b8601cfed9b" />
<img width="1409" height="959" alt="Screenshot 2025-10-30 at 8 36 43 AM" src="https://github.com/user-attachments/assets/1144adcb-2a58-4adc-896c-118404ea682d" />
<img width="1409" height="959" alt="Screenshot 2025-10-30 at 8 41 20 AM" src="https://github.com/user-attachments/assets/602c5cba-67b1-4463-94f9-5adc9bcb03a8" />
<img width="1409" height="959" alt="Screenshot 2025-10-30 at 8 41 27 AM" src="https://github.com/user-attachments/assets/985d7843-a387-4b6e-ae95-4a446804d430" />

### 11. Set up a log monitoring 
- sudo nano /usr/local/bin/security-check.sh
<img width="1381" height="898" alt="Screenshot 2025-10-30 at 8 46 58 AM" src="https://github.com/user-attachments/assets/32eb1a96-7241-489b-9101-fe84c4718e09" />
#### Testing script
<img width="1381" height="898" alt="Screenshot 2025-10-30 at 8 48 21 AM" src="https://github.com/user-attachments/assets/fbee93d5-a125-4764-86e5-13ebabb18736" />

