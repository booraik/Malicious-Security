#!/bin/bash

if [ $# -ge 1 ]; then
  HOME=$1
else
  HOME="."
fi
cd $HOME

# 1. Update latest version
git --git-dir=$HOME/.git/ pull origin main

# 2. update blacklist from local detection
script/fail2ban_sshd_to_blacklist.sh
script/ipset_to_blacklist.sh rdp blacklist_rdp
script/ipset_to_blacklist.sh rdp blacklist_rdp
script/ipset_to_blacklist.sh http blacklist_http

# 3. commit && push
git add blacklist_ip
git commit -m  "[`date`] Commited by `hostname`"
git push origin main

# 4. apply
script/blacklist_to_ipset.sh
fail2ban-client unban --all
