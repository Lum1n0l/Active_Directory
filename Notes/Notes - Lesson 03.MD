Powershell: Random Users & Weak Passwords (Active Directory #03)

With a lot of assistance from John, I have written the Powershell script called random_domain.ps1. 

This script, takes data from the 4 .txt files within the same directory (first_names, surnames, passwords & group_names) to generate a JSON File containing a list of 100 randomly generated user templates and 10 group templates. 

I have taken the output created by this script (out.json) and supplied this into my previously created script (gen_ad.ps1) that takes a JSON List supplied and creates Active Directory Groups & Users in order to create these users and groups on my DC1 domain controller. 

Weak Passwords: 

The default password Policy that exists on the domain controller prevents the users I supplied via JSON from being created (They are all created but stay inactive). 
    In order to work around this, I modified the default Password Policy by using 2 methods...

    1) I ran this script on DC1 S
        Set-ADDefaultDomainPasswordPolicy -Identity adlabs.com -ComplexityEnabled 0 -MinPasswordLength 1
    
    2) I included, within the gen_ad.ps1 script, the following:

            function WeakenPasswordPolicy(){

            secedit /export /cfg C:\Windows\Tasks\secpol.cfg
            (Get-Content C:\Windows\Tasks\secpol.cfg).replace("PasswordComplexity = 1", "PasswordComplexity = 0") | Out-File C:\Windows\Tasks\secpol.cfg
            secedit /configure /db c:\windows\security\local.sdb /cfg c:\Windows\Tasks\secpol.cfg /areas SECURITYPOLICY
            Remove-Item -force C:\Windows\Tasks\secpol.cfg -confirm:$false
}
            WeakenPasswordPolicy
        
        This Weakened the password policy and allowed my users with poor passwords to be created. 
