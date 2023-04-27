To start, I used to Pro version of VMWare Workstation to create the structure for my Active Directory Network. 

I downloaded a copy og Microsoft Server 2022 to use for my Domain Controllers. 

I setup 2 VMs, one using Server 2022 and another using Windows 11 Pro. Once setup and kitted with VMWare Tools, I created snapshots of both of these VMs in order to use these as templates for clones to save time later. 

I created a Domain Controller, named DC1.
I also created a Windows 11 Pro Clone, to use as a Management Client. 

Via Powershell, I added my Domain Controllers IP address to its list of Trusted Hosts.

/// Start-Service WinRM
/// Set-Item wsman:\localhost\Client\TrustedHosts -Value *IP*

I then connected to my domain controller from my management client, from within Powershell, using the below command: 

New-PSSession -ComputerName IP -Credential (Get-Credential)
Enter-PSSession SESSIONID

To install Activate Directory, preferably do this directly on the DC (Not via PS Remoting) due to issues with sconfig not spawning properly. 

- Set Hostname to something nice
- From sconfig, 8 for Network Settings
- Option 1, for only network adaptor
- Option 1, Set network adaptor address, then S for Static IP
- Choose a Static IP within current octet 
- Set Preferred DNS Server as the same Static IP
- Restart

From PS, on DC1: 

Run: 
    Install-WindowsFeature AD-Domain-Services -IncludemanagementTools

Then: 
    Import-Module ADDSDeployment
    Install-ADDSForest
    Enter 'Y'

Once restarted, I will need to go back in and reset the preferred DNS back to our own Static IP.

As we have set our own Static IP, I will need to add this to Trusted Hosts on the Management Client (See above)

We now create a new Workstation, from a Clone of Win 11 from earlier, this ones named WS1. 

To Connect this Workstation to the Domain Controller, do either of the following: 

    - In PS, Run: 

    Add-Computer -DomainName DOMAINNAME -Credential DOMAINNAME\Administrator -Force -Restart

    - Or, Start, then 'Access Work or School', Enter Domain Name, Skip adding users, Restart. 


Following this, we will need to create Groups & Users for our Active Directory from either within the DC1 box itself or from the Management Client using PS Remoting. 
*** See the gen_ad.ps1 & ad_schema.json files for a view on how to automate this *** 