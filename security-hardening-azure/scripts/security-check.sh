#!/bin/bash


echo "=== Security Status Report ==="
echo "Generated: $(date)"
echo ""

echo "=== Failed Login Attempts ==="
grep "Failed password" /var/log/auth.log 2>/dev/null | tail -5 || echo "No failed login attempts found or log not accessible"

echo ""
echo "=== Firewall Status ==="
sudo ufw status numbered 2>/dev/null || echo "UFW not installed or not accessible"

echo ""
echo "=== Fail2Ban Status ==="
sudo fail2ban-client status sshd 2>/dev/null || echo "Fail2ban not running or SSH jail not configured"

echo ""
echo "=== Disk Usage ==="
df -h

echo ""
echo "=== Active Connections ==="
sudo ss -tulpn | grep LISTEN

echo ""
echo "=== Last 5 Logins ==="
last -5

echo ""
echo "=== System Updates Available ==="
apt list --upgradable 2>/dev/null | grep -v "Listing..." || echo "Unable to check for updates (apt not available)"
