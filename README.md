# Malicious
for Malicious list
* IP
  * ssh
  * rdp(mstsc)
  * http
  * [Rescure](https://rescure.me/feeds.html)
  
Using iptables or firewalld or ipset
  

## Install
From CentOS
### 1. iptables
```
yum install -y iptables
iptables -N BLACKLIST
iptables -C -A BLACKLIST -s $1 -j REJECT --reject-with icmp-port-unreachable
iptables -I INPUT -j BLACKLIST
```
### 2. iptables, ipset
yum install -y iptables ipset

### 3. firewalld
yum install -y firewalld

### 4. firewalld, ipset
yum install -y firewalld ipset

## Scheduling
```
* * 0 * * 
```

## Command

```
# Using ipset
for ip in $(grep -Eo "([0-9]{1,3}[\.]){3}[0-9]{1,3}" ssh.txt | sort | uniq); do ipset -A blacklist_ssh $ip; done 

# Using iptables
for ip in $(grep -Eo "([0-9]{1,3}[\.]){3}[0-9]{1,3}" ssh.txt | sort | uniq); do iptables -A INPUT -s $ip -j REJECT --reject-with icmp-port-unreachable; done 

# Using iptables & ipset
iptables -I INPUT -m set --match-set blacklist_ssh src -j REJECT --reject-with icmp-port-unreachable
```

