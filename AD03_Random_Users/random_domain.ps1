param( [Parameter(Mandatory=$true)] $OutputJSONFile )

$group_names = [System.Collections.ArrayList](Get-Content "AD03_Random_Users/group_names.txt")
$first_names = [System.Collections.ArrayList](Get-Content "AD03_Random_Users/first_names.txt")
$surnames = [System.Collections.ArrayList](Get-Content "AD03_Random_Users/surnames.txt")
$passwords = [System.Collections.ArrayList](Get-Content "AD03_Random_Users/passwords.txt")

$groups = @()
$users = @()

$num_groups = 10
for ( $i = 0; $i -lt $num_groups; $i++ ){
    $group_name = (Get-Random -InputObject $group_names)
    $group = @{ "name" = "$group_name" }
    $groups += $group
    $group_names.Remove($group_name)
}

$num_users = 100
for ( $i = 0; $i -lt $num_users; $i++ ){
    $first_name = (Get-Random -InputObject $first_names)
    $surname = (Get-Random -InputObject $surnames)
    $password = (Get-Random -InputObject $passwords)
    
    $new_user = @{ 
        "name"="$first_name $surname"
        "password" = "$password"
        "groups" = @( (Get-Random -InputObject $groups).name ) 
    }

    $users += $new_user

    $first_names.Remove($first_name)
    $surnames.Remove($surname)
    $passwords.Remove($password)
}

Write-Output @{ 
    "domain"= "adlabs.com"
    "groups"=$groups
    "users"=$users
} | ConvertTo-Json | Out-File $OutputJSONFile