#!/bin/bash
# alert for accounts with non-BCH accounts

tmpfile="/tmp/planscan.txt"
host=`hostname`
resellerlist=`cut -d':' -f1 /var/cpanel/resellers`

grep -H PLAN /var/cpanel/users/* | egrep -iv "DevClass|All\ The\ Things|Farmstead|Garden\ Patch|Rancher" |egrep -v "$resellerlist" >> $tmpfile

if [ -s $tmpfile ]; 
	then
#		cat $tmpfile
		mail -s "Plan scan $host" status@bch-status.com < $tmpfile
		/bin/rm -f $tmpfile
	else
 	   exit 0
fi