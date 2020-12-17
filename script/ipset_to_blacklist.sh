#!/bin/bash

if [ $# -lt 2 ]; then
  echo "Usage: ipset_to_blacklist.sh <ssh | rdp | http> <ipset name> [Home directory]"
  exit
fi

if [ $# -ge 3 ]; then
  HOME=$3
else
  HOME="."
fi

HOME="."
cd $HOME

TARGET=$1
IPSET_NAME=$2

cp blacklist_ip/$TARGET.txt .tmp
echo $TARGET Blacklist IP address count: $(cat .tmp| wc -w)

NEW_IP=$(ipset save $IPSET_NAME | grep -Eo "([0-9]{1,3}[\.]){3}[0-9]{1,3}")
echo New Malicious IP address count: $(echo $NEW_IP | wc -w)

printf "%s\n" "${NEW_IP[@]}" >> .tmp
echo Added Blacklist IP address count: $(cat .tmp | wc -w)

cat .tmp | sort -h | uniq > blacklist_ip/$TARGET.txt
rm -f .tmp
echo Uniq Blacklist IP address count: $(cat blacklist_ip/$TARGET.txt | wc -w)
