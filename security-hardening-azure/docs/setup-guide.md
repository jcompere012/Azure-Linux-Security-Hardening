# Linux VM Hardening Lab Setup

## Create Resourse group
- security-hardening-rg

## Create Virtual Network
- security-vnet

## Create Virtual Machine
- security-linux-vm- ubuntu 22.04 LTS
- download key pair: security-linux-vm_key.pem

## Operating system 
- MacOs

### 1. Open terminal 
- cd ~/Downlaods
- chmod 400 security-linux-vm_key.pem
- SSH -i security-linux-vm_key.pem azureuser@48.194.95.70

### 2. System hardening steps

#### Update and Upgrade packages
- sudo apt update && sudo apt upgrade -y
#### Remove unnecessary packages
- sudo apt autoremove -y 

### 3. Enable automatic security updates
 #### Install unattended-upgrades -y
- sudo apt install unattended-upgrades
- sudo dpkg-reconfigure -plow unattended-upgrades

### 4. List and potentially disable unnecesary services
  - sudo systemctl list-units --type=service --state=running

### 5. Configure UFW Firewall and allow port 22 
- sudo apt install ufw -y
- sudo ufw default deny incoming
- sudo ufw default allow outgoing 
- sudo ufw allow 22/tcp
- sudo ufw enable
- sudo ufw status verbose
- sudo ufw loggin on ( log firewall activity)

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

### 7. Auditing
- sudo apt install auditd audispd-plugins -y 
- sudo systemctl start auditd
- sudo systemctl enable auditd
- sudo nano /etc/audit/rules.d/hardening.rules
- sudo augenrules --load
- sudo systemctl restart auditd

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


### 9. Set secure file permissions
- sudo chmod 600 /etc/ssh/sshd_config
- sudo chmod 600 /etc/shadow
- sudo chmod 600 /etc/gshadow
- sudo chmod 644 /etc/passwd
- sudo chmod 644 /etc/group

### 10. install lynis( security audit)  and rkhunter (scan for rootkits)
- # Install security scanning tools
- sudo apt install lynis rkhunter chkrootkit -y
- sudo lynis audit system
- sudo rkhunter --check --skip-keypress (rootkits scan)


### 11. Set up a log monitoring Scripts
- sudo nano /usr/local/bin/security-check.sh
