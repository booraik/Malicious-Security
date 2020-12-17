#!/bin/bash

iptables -N BLACKLIST 2> /dev/null
iptables -F BLACKLIST 2> /dev/null
iptables -A BLACKLIST -m set --match-set blacklist_ssh src -j REJECT --reject-with icmp-port-unreachable
iptables -A BLACKLIST -m set --match-set blacklist_rdp src -j REJECT --reject-with icmp-port-unreachable
iptables -A BLACKLIST -m set --match-set blacklist_http src -j REJECT --reject-with icmp-port-unreachable
iptables -A BLACKLIST -m set --match-set blacklist_rescure src -j REJECT --reject-with icmp-port-unreachable

iptables -D INPUT -j BLACKLIST 2> /dev/null
iptables -I INPUT -j BLACKLIST
