param(
    [Parameter(Mandatory=$true)] $OutputJSONFile, 
    [int]$UserCount,
    [int]$GroupCount,
    [int]$LocalAdminCount
)

$group_names = [System.Collections.ArrayList](Get-Content "group_names.txt")
$first_names = [System.Collections.ArrayList](Get-Content "first_names.txt")
$surnames = [System.Collections.ArrayList](Get-Content "surnames.txt")
$passwords = [System.Collections.ArrayList](Get-Content "passwords.txt")

$groups = @()
$users = @()

# Default User Count set to 5, if not specified via parameter switch.
if ( $UserCount -eq 0 ){
    $UserCount = 5
} 

# Default Group Count set to 1, if not specified via parameter switch.
if ( $GroupCount -eq 0 ){
    $GroupCount = 1
} 

if ( $LocalAdminCount -ne 0){
    $local_admin_indexes = @()
    while (($local_admin_indexes | Measure-Object ).Count -lt $LocalAdminCount){
        $random_index = (Get-Random -InputObject (1..($UserCount)) | Where-Object { $local_admin_indexes -notcontains $_ } )
        $local_admin_indexes += @( $random_index )
    }
}  

for ( $i = 1; $i -le $GroupCount; $i++ ){
    $group_name = (Get-Random -InputObject $group_names)
    $group = @{ "name" = "$group_name" }
    $groups += $group
    $group_names.Remove($group_name)
}

for ( $i = 1; $i -le $UserCount; $i++ ){
    $first_name = (Get-Random -InputObject $first_names)
    $surname = (Get-Random -InputObject $surnames)
    $password = (Get-Random -InputObject $passwords)
    
    $new_user = @{ 
        "name"="$first_name $surname"
        "password" = "$password"
        "groups" = @( (Get-Random -InputObject $groups).name ) 
    }

    if ( $local_admin_indexes | Where { $_ -eq $i } ){
        $new_user["local_admin"] = $true
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