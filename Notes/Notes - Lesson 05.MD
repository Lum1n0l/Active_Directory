Bruteforcing Domain Passwords

Scenario:

We have conducted initial investigations, research and OSINT on a target company/organisation that we are conducting a pen test on. We have managed to obtain a list of potential employee names (usernames). 



To start, I have created a list of usernames and saved this in my Kali VM. 
This will be fed into a tool such as Crackmapexec alongside a password list in an attempt to brute force some of those credentials. :)

To copy lines from within another document, you can use the following:
    head -n AMOUNTOFLINES PATHTOFILE > OUTFILE 
    (i.e. head-n 1000 /usr/share/wordlists/rockyou.txt > passwords.txt)

I also added the IP Address of our Domain Controller to a text file called target.txt

Using my newly created usernames, passwords and targets files I supplied these to crackmapexec to try and brute force some credentials. 

Once I have discovered a user's credentials, I can input these directly into crackmapexec to poll the Domain Controller for further information, such as the password policy (--pass-pol).

I can add --continue-on-success as a switch to crackmapexec, and if I pipe in grep '[+]' on the end of the command I can filter the output from crackmapexec so that only my hits are displayed. This makes collecting a list of credentials simple :)

According to John, it is worth while trying to run crackmapexec using different protocals that are available as I may find more success with some over others in different environments. 