#!/bin/bash

HOME="."

ipset create blacklist_rdp hash:net hashsize 4096 2> /dev/null
ipset create blacklist_ssh hash:net hashsize 4096 2> /dev/null
ipset create blacklist_http hash:net hashsize 4096 2> /dev/null
ipset create blacklist_rescure hash:net hashsize 4096 2> /dev/null

ipset flush blacklist_rdp
ipset flush blacklist_ssh
ipset flush blacklist_http
ipset flush blacklist_rescure

for IP in $(grep -Eo "([0-9]{1,3}[\.]){3}[0-9]{1,3}" $HOME/blacklist_ip/rdp.txt | sort -h | uniq)
do
ipset -A blacklist_rdp $IP/32
done

for IP in $(grep -Eo "([0-9]{1,3}[\.]){3}[0-9]{1,3}" $HOME/blacklist_ip/ssh.txt | sort -h | uniq)
do
ipset -A blacklist_ssh $IP/32
done

for IP in $(grep -Eo "([0-9]{1,3}[\.]){3}[0-9]{1,3}" $HOME/blacklist_ip/http.txt | sort -h | uniq)
do
ipset -A blacklist_http $IP/32
done

for IP in $(grep -Eo "([0-9]{1,3}[\.]){3}[0-9]{1,3}" $HOME/blacklist_ip/rescure.txt | sort -h | uniq)
do
ipset -A blacklist_rescure $IP/32
done
