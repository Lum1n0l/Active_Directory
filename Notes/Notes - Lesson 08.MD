Generating Local Admins Across Hosts

sysprep: 

    I can use the sysprep command in the windows terminal to strip a windows installation of its unique identifiers (SID) etc, so that it can be imaged/cloned easily without the domain complaining that it appears to be a cloned mirror copy of another workstation. 


In order to be able to create local admins across hosts, I need to be able to Invoke-Command from the DC onto a Workstation. (WS1/WS2 etc). For this to work, I need to Enable-PSRemoting (similar to when I set up the DC).

Viewing the Trusted Hosts file (Once PSRemoting enabled): 

    get-item wsman:\localhost\client\trustedhosts

Editing the Trusted Hosts file (Once PSRemoting enabled): 

    set-item wsman:\localhost\client\trustedhosts -Value "NEWVALUE"


Invoke-Command from the DC to a WS only works when entered directly into the DC, instead of via a PSSession. 

gen_ad updated with a foreach loop that creates local admins across based on which machines are specified within the ad_schema file. 