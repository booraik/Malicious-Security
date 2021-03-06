#!/bin/bash

if [ $# -ge 1 ]; then
  HOME=$1
else
  HOME="."
fi
cd $HOME

IPSET=/usr/sbin/ipset
SORT='/usr/bin/sort -n -t . -k 1,1 -k 2,2 -k 3,3 -k 4,4'

$IPSET create blacklist_rdp hash:net hashsize 4096 2> /dev/null
$IPSET create blacklist_ssh hash:net hashsize 4096 2> /dev/null
$IPSET create blacklist_http hash:net hashsize 4096 2> /dev/null
$IPSET create blacklist_rescure hash:net hashsize 4096 2> /dev/null

$IPSET flush blacklist_rdp
$IPSET flush blacklist_ssh
$IPSET flush blacklist_http
$IPSET flush blacklist_rescure

for IP in $(grep -Eo "([0-9]{1,3}[\.]){3}[0-9]{1,3}" blacklist_ip/rdp.txt | $SORT | uniq)
do
    $IPSET -A blacklist_rdp $IP/32
done

for IP in $(grep -Eo "([0-9]{1,3}[\.]){3}[0-9]{1,3}" blacklist_ip/ssh.txt | $SORT | uniq)
do
    $IPSET -A blacklist_ssh $IP/32
done

for IP in $(grep -Eo "([0-9]{1,3}[\.]){3}[0-9]{1,3}" blacklist_ip/http.txt | $SORT | uniq)
do
    $IPSET -A blacklist_http $IP/32
done

for IP in $(grep -Eo "([0-9]{1,3}[\.]){3}[0-9]{1,3}" blacklist_ip/rescure.txt | $SORT | uniq)
do
    $IPSET -A blacklist_rescure $IP/32
done
