#!/bin/bash

firewall-cmd  --permanent --new-ipset=blacklist_rdp --type hash:net
firewall-cmd  --permanent --new-ipset=blacklist_ssh --type hash:net
firewall-cmd  --permanent --new-ipset=blacklist_http --type hash:net
firewall-cmd  --permanent --new-ipset=blacklist_rescure --type hash:net

firewall-cmd --permanent --direct --add-rule ipv4 filter INPUT 0 -m set --match-set blacklist_rdp src -j DROP
firewall-cmd --permanent --direct --add-rule ipv4 filter INPUT 0 -m set --match-set blacklist_ssh src -j DROP
firewall-cmd --permanent --direct --add-rule ipv4 filter INPUT 0 -m set --match-set blacklist_http src -j DROP
firewall-cmd --permanent --direct --add-rule ipv4 filter INPUT 0 -m set --match-set blacklist_rescure src -j DROP

#firewall-cmd --permanent --get-ipsets
#firewall-cmd --permanent --info-ipset=blacklist_ssh
#ipset list

firewall-cmd --reload
