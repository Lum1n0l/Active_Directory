Bloodhound Domain Enumeration

BloodHound Github: https://github.com/BloodHoundAD/BloodHound

Bloodhound is a tool that interrogates an Active Directory environment to discover complex vulnerabilities and trust relationships that wouldnt otherwise be immediately clear. 

I have following the documentation for Bloodhound online to setup and install bloodhound and one of its collectors on my Kali VM (neo4j). 

If I want to start neo4j locally, I can run the 'neo4j console' command to do this. 

Once neo4j is running, I need to download and run the Bloodhound GUI from their Github. 

Once downloaded and extracted, chmod the executable and run WITHOUT sudo and also appended with the following flag (--no-sandbox). 

Change the default credentials via Firefox, (http://localhost:7474) and then I can log into the Bloodhound GUI.


Collectors: 

In order to generate some data for the Bloodhound GUI, I need to use a collector.

BloodHound Python Collector Github: https://github.com/fox-it/BloodHound.py

The bloodhound-python tool preinstalled in kali, is a way of doing this remotely without having first compromised and having access to a machine within the domain. I input details of my domain and the credentials of a low privileged user to interrogate the domain. 

In order for this to work, I need to update my /etc/hosts file to include the domain at its corrosponding IP. AND I also need to update my /etc/resolv.conf file to update the preset nameserver from the default, to the IP of the domain controller. That way when it resolves DNS requests, it looks to the domain controller. 

Example input to bloodhound-python:
    bloodhound-python -u cwatson -p kelly -dc dc1.adlabs.com --disable-autogc -d adlabs.com

Running this python script searches through the Active Directory environment, looking for info on number of domains, computers, users, groups etc within the AD. 

These results are seperated by catagory and are written to seperate JSON files within the current directory. 

By default, bloodhound-python will query the domain using LDAP. This can be specified with the --collectionMethod or -c switch. Specify all methods with -c All

Once I have collected this data, I can load up the Bloodhound GUI again and select the option on the right hand side to upload this data into Bloodhound, which can then be viewed more graphically for analysis :)