# Malicious
for Malicious list
* IP
  * ssh
  * rdp(mstsc)
  * http
  * [Rescure](https://rescure.me/feeds.html)
  
Using iptables or firewalld or ipset
  

# Install
From CentOS

## 1. iptables using ipset
```
yum install -y iptables ipset
script/iptables_ipset.sh
```
## 2. firewalld using ipset
```
yum install -y firewalld ipset
script/firewall_ipset.sh
```

# Scheduling
```
# update latest version && fail2ban ssh to blacklist && flush all ipset && apply blacklist ip
0 0 * * 0 /root/github/Malicious-Security/script/crontab.sh /root/github/Malicious-Security/
```

# Script

## blacklist_to_ipset.sh
All blacklist_ip/* ip address apply ipset
* blacklist_rdp
* blacklist_ssh
* blacklist_http
* blacklist_rescure
```
Usage: ./blacklist_to_ipset.sh <Home directory>
```

## crontab.h
Auto apply ipset and update 
1. update latest version
2. fail2ban ssh to blacklist
3. flush all ipset
4. apply blacklist ip
5. commit applied blacklist_ip
```
Usage: ./crontab.sh <Home directory>
```

## fail2ban_sshd_to_blacklist.sh
fail2ban blocked ip to blacklist_ip/ssh.txt
```
Usage: ./fail2ban_sshd_to_blacklist.sh <Home directory>
```

## firewall_ipset.sh
Init firewalld and ipset

## ipset_to_blacklist.sh
ipset ip address to blacklist_ip/*
```
Usage: ipset_to_blacklist.sh <ssh | rdp | http> <ipset name> [Home directory]
```

## iptables_ipset.sh
Init iptables and ipset


# Command

```
# ssh.txt to ipset
for ip in $(grep -Eo "([0-9]{1,3}[\.]){3}[0-9]{1,3}" ssh.txt | sort | uniq); do ipset -A blacklist_ssh $ip; done 

# ssh.txt to iptables
for ip in $(grep -Eo "([0-9]{1,3}[\.]){3}[0-9]{1,3}" ssh.txt | sort | uniq); do iptables -A INPUT -s $ip -j REJECT --reject-with icmp-port-unreachable; done 

# Using iptables & ipset
iptables -I INPUT -m set --match-set blacklist_ssh src -j REJECT --reject-with icmp-port-unreachable

# firewall-cmd cli
firewall-cmd  --permanent --new-ipset=blacklist_ssh --type hash:net
firewall-cmd --permanent --direct --add-rule ipv4 filter INPUT 0 -m set --match-set blacklist_ssh src -j DROP
firewall-cmd --direct --get-all-rules
```

