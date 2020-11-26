# Malicious
for Malicious list

## IP
ssh, mstsc brute force ip list

## Command

```
# Using ipset
for ip in $(grep -Eo "([0-9]{1,3}[\.]){3}[0-9]{1,3}" ssh.txt | sort | uniq); do ipset -A blacklist_ssh $ip; done 

# Using iptables
for ip in $(grep -Eo "([0-9]{1,3}[\.]){3}[0-9]{1,3}" ssh.txt | sort | uniq); do iptables -A INPUT -s $ip -j REJECT --reject-with icmp-port-unreachable; done 

# Using iptables & ipset
iptables -I INPUT -m set --match-set blacklist_ssh src -j REJECT --reject-with icmp-port-unreachable
```

