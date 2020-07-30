$users=Get-WmiObject -Class Win32_UserAccount | select Name
Remove-LocalUser -Name $users.Name
$password = ConvertTo-SecureString "password" -AsPlainText -Force
New-LocalUser "Newuser" -Password $password -Fullname "User" -Description "new"
Add-LocalGroupMember -Group "Administrators" -Member "NewUser"
