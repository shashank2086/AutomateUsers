$users=Get-WmiObject -Class Win32_UserAccount | select Name #fetching all users and storing in the array
Remove-LocalUser -Name $users.Name #removing all users in the given array 
$password = ConvertTo-SecureString "password" -AsPlainText -Force # converting "password" into a SecureString which can be manually changed according the user
New-LocalUser "Newuser" -Password $password -Fullname "User" -Description "new" # Adding New-User
Add-LocalGroupMember -Group "Administrators" -Member "NewUser" # Giving Previlages
