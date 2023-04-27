
$group_names = (Get-Content "AD03_Random_Users/group_names.txt")
$first_names = (Get-Content "AD03_Random_Users/first_names.txt")
$surnames = (Get-Content "AD03_Random_Users/surnames.txt")
$passwords = (Get-Content "AD03_Random_Users/passwords.txt")

$groups = @()

$num_groups = 10



echo (Get-Random -InputObject $group_names) 