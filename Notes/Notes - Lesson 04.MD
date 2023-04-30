Active Directory #04 - Tearing Down the Domain Controller

To add a PC to a domain from the terminal/powershell:
    Add-Computer -DomainName adlabs.com -Restart

To remove a PC:
    Remove-Computer -UnjoinDomaincredential adlabs.com\Administrator -PassThru -Verbose -Restart

I can store login credentials for the Domain Controller as a variable within the terminal:
    $cred = (Get-Credential)

This can now be passed back in when generating a new PS Session:
    $dc = New-PSSession -ComputerName IP -Credential $cred

While logged into the workstation (WS1) as any domain user, I can run the following command to view a list of all domain users: 
    net user /domain

