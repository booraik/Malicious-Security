#!/bin/bash

HOME="."
cd $HOME

## pull latest git
git --git-dir=$HOME/.git/ pull origin main
cp blacklist_ip/ssh.txt .tmp
echo Blacklist IP address count: $(cat .tmp| wc -w)

NEW_IP=$(/usr/bin/fail2ban-client status sshd | grep -Eo "([0-9]{1,3}[\.]){3}[0-9]{1,3}")
echo New Malicious IP address count: $(echo $NEW_IP | wc -w)

printf "%s\n" "${NEW_IP[@]}" >> .tmp
echo Added Blacklist IP address count: $(cat .tmp | wc -w)

uniq .tmp | sort -h > blacklist_ip/ssh.txt
rm -f .tmp
echo Uniq Blacklist IP address count: $(cat blacklist_ip/ssh.txt | wc -w)

## Commit & push blacklist ssh ip addresses to github
git add blacklist_ip/ssh.txt
git commit -m  "[`date`] Commited by `hostname`"
git push origin main
