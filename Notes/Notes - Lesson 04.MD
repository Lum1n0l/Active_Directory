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



I have added a switch into my gen_ad.ps1 script. This allows me to run the script with a switch included on the command line. 
I have added functionality for an 'Undo' switch. 
This allows me, by specifying -Undo while running gen_ad.ps1 to completely delete all users and groups previously created by the script. 